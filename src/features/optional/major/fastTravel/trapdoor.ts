import g from "../../../../globals";
import {
  getGridEntities,
  isPostBossVoidPortal,
  removeGridEntity,
} from "../../../../misc";
import { FastTravelEntityType } from "./enums";
import * as fastTravel from "./fastTravel";
import * as nextFloor from "./nextFloor";
import * as state from "./state";

const FAST_TRAVEL_ENTITY_TYPE = FastTravelEntityType.Trapdoor;

// ModCallbacks.MC_POST_NEW_ROOM (19)
export function postNewRoom(): void {
  initAll();
}

function initAll() {
  for (const gridEntity of getGridEntities()) {
    const saveState = gridEntity.GetSaveState();
    if (saveState.Type === GridEntityType.GRID_TRAPDOOR) {
      fastTravel.init(gridEntity, FAST_TRAVEL_ENTITY_TYPE, shouldSpawnOpen);
    }
  }
}

// ModCallbacksCustom.MC_POST_GRID_ENTITY_UPDATE
// GridEntityType.GRID_TRAPDOOR
export function postGridEntityUpdateTrapdoor(gridEntity: GridEntity): void {
  if (isPostBossVoidPortal(gridEntity)) {
    return;
  }

  // There is no way to manually travel to the "Infinite Basements" Easter Egg floors,
  // so just disable the fast-travel feature if this is the case
  if (g.seeds.HasSeedEffect(SeedEffect.SEED_INFINITE_BASEMENT)) {
    return;
  }

  // In some situations, trapdoors should be removed entirely
  if (shouldRemove()) {
    removeGridEntity(gridEntity);
    return;
  }

  // Keep it closed on every frame so that we can implement our own custom functionality
  gridEntity.State = TrapdoorState.CLOSED;

  fastTravel.init(gridEntity, FAST_TRAVEL_ENTITY_TYPE, shouldSpawnOpen);
  fastTravel.checkShouldOpen(gridEntity, FAST_TRAVEL_ENTITY_TYPE);
  fastTravel.checkPlayerTouched(gridEntity, FAST_TRAVEL_ENTITY_TYPE, touched);
}

function shouldRemove() {
  const stage = g.l.GetStage();

  // Delete the Womb trapdoor that spawns after Mom if the goal of the run is the Boss Rush
  if (
    stage === 6 &&
    g.race.status === "in progress" &&
    g.race.goal === "Boss Rush"
  ) {
    return true;
  }

  return false;
}

export function shouldSpawnOpen(entity: GridEntity | EntityEffect): boolean {
  if (g.r.GetFrameCount() === 0) {
    // If we just entered a new room with enemies in it, spawn the trapdoor closed so that the
    // player has to defeat the enemies first before using the trapdoor
    if (!g.r.IsClear()) {
      return false;
    }

    // If we just entered a new room that is already cleared,
    // spawn the trapdoor closed if we are standing close to it, and open otherwise
    return state.shouldOpen(entity, FAST_TRAVEL_ENTITY_TYPE);
  }

  // After defeating Satan, the trapdoor should always spawn open
  // (because there is no reason to remain in Sheol)
  if (g.l.GetStage() === 10) {
    return true;
  }

  // Trapdoors created after a room has already initialized should spawn closed by default
  // e.g. trapdoors created after bosses should spawn closed so that players do not accidently jump
  // into them
  // e.g. trapdoors created by We Need to Go Deeper! should spawn closed because the player will
  // be standing on top of them
  return false;
}

function touched(entity: GridEntity | EntityEffect, player: EntityPlayer) {
  nextFloor.init(entity, player, false);
}
