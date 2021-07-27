import g from "../../../../globals";
import {
  getGridEntities,
  getRoomIndex,
  isAntibirthStage,
  isPostBossVoidPortal,
  removeGridEntity,
} from "../../../../misc";
import { FastTravelEntityType } from "./enums";
import * as fastTravel from "./fastTravel";
import { setFadingToBlack } from "./setNewState";
import * as state from "./state";

const FAST_TRAVEL_ENTITY_TYPE = FastTravelEntityType.Trapdoor;

// ModCallbacks.MC_POST_NEW_ROOM (19)
export function postNewRoom(): void {
  initAll();
}

function initAll() {
  for (const gridEntity of getGridEntities()) {
    const saveState = gridEntity.GetSaveState();
    if (
      saveState.Type === GridEntityType.GRID_TRAPDOOR &&
      !shouldIgnore(gridEntity)
    ) {
      fastTravel.init(gridEntity, FAST_TRAVEL_ENTITY_TYPE, shouldSpawnOpen);
    }
  }
}

function shouldIgnore(gridEntity: GridEntity) {
  const stage = g.l.GetStage();

  if (isPostBossVoidPortal(gridEntity)) {
    return true;
  }

  // There is no way to manually travel to the "Infinite Basements" Easter Egg floors,
  // so just disable the fast-travel feature if this is the case
  if (g.seeds.HasSeedEffect(SeedEffect.SEED_INFINITE_BASEMENT)) {
    return true;
  }

  // Don't replace the trap door that leads to Mother
  if (stage === 8 && isAntibirthStage()) {
    return true;
  }

  return false;
}

// ModCallbacksCustom.MC_POST_GRID_ENTITY_UPDATE
// GridEntityType.GRID_TRAPDOOR
export function postGridEntityUpdateTrapdoor(gridEntity: GridEntity): void {
  if (shouldIgnore(gridEntity)) {
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
  const roomIndex = getRoomIndex();
  const antibirthHeartKilled = g.g.GetStateFlag(
    GameStateFlag.STATE_MAUSOLEUM_HEART_KILLED,
  );

  // If the goal of the race is the Boss Rush, delete the Womb trapdoor that spawns after Mom
  if (
    g.race.status === "in progress" &&
    g.race.myStatus === "racing" &&
    g.race.goal === "Boss Rush" &&
    stage === 6
  ) {
    return true;
  }

  // If the goal of the race is Hush, delete the trapdoor that spawns after It Lives!
  if (
    g.race.status === "in progress" &&
    g.race.myStatus === "racing" &&
    g.race.goal === "Hush" &&
    stage === 8 &&
    roomIndex !== GridRooms.ROOM_BLUE_WOOM_IDX
  ) {
    return true;
  }

  // If the goal of the race is Hush, delete the trapdoor that spawns after Hush
  if (
    g.race.status === "in progress" &&
    g.race.myStatus === "racing" &&
    g.race.goal === "Hush" &&
    stage === 9 &&
    roomIndex !== GridRooms.ROOM_THE_VOID_IDX
  ) {
    return true;
  }

  // If the goal of the race is Mother, delete trapdoors that leads to normal floors
  if (
    g.race.status === "in progress" &&
    g.race.myStatus === "racing" &&
    g.race.goal === "Mother"
  ) {
    // Basement 1 --> Downpour 1
    if (
      stage === 1 &&
      !isAntibirthStage() &&
      roomIndex !== GridRooms.ROOM_SECRET_EXIT_IDX
    ) {
      return true;
    }

    // Downpour 2 --> Mines 1
    if (
      stage === 2 &&
      isAntibirthStage() &&
      roomIndex !== GridRooms.ROOM_SECRET_EXIT_IDX
    ) {
      return true;
    }

    // Mines 2 --> Mausoleum 1
    if (
      stage === 4 &&
      isAntibirthStage() &&
      roomIndex !== GridRooms.ROOM_SECRET_EXIT_IDX
    ) {
      return true;
    }

    // Mausoleum 2 --> Corpse 1
    if (stage === 6 && isAntibirthStage() && !antibirthHeartKilled) {
      return true;
    }
  }

  return false;
}

function shouldSpawnOpen(entity: GridEntity | EntityEffect) {
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
  // e.g. trapdoors created after bosses should spawn closed so that players do not accidentally
  // jump into them
  // e.g. trapdoors created by We Need to Go Deeper! should spawn closed because the player will
  // be standing on top of them
  return false;
}

function touched(entity: GridEntity | EntityEffect, player: EntityPlayer) {
  setFadingToBlack(entity, player, false);
}
