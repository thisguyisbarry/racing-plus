import {
  CollectibleAnimation,
  EntityPartition,
  PlayerItemAnimation,
} from "isaac-typescript-definitions";
import { doesEntityExist, getEntities, logError } from "isaacscript-common";
import { CollectibleTypeCustom } from "../../enums/CollectibleTypeCustom";
import { EntityTypeCustom } from "../../enums/EntityTypeCustom";
import g from "../../globals";
import { mod } from "../../mod";
import { raceFinish } from "../race/raceFinish";
import { speedrunIsFinished } from "../speedrun/exported";
import * as speedrun from "../speedrun/speedrun";
import { isSeededDeathActive } from "./seededDeath/v";

const TROPHY_TOUCH_DISTANCE = 24; // 25 is a bit too big

const v = {
  level: {
    trophyIndex: null as int | null,
  },
};

export function init(): void {
  mod.saveDataManager("trophy", v);
}

export function spawnTrophy(position: Vector): void {
  // Don't do anything if a trophy already exists in the room. (This can happen if code earlier on
  // in the `POST_NEW_ROOM` callback spawned a Big Chest or a trophy.)
  if (v.level.trophyIndex !== null) {
    return;
  }

  const [_entity, index] = mod.spawnPersistentEntity(
    EntityTypeCustom.RACE_TROPHY,
    0,
    0,
    position,
  );
  v.level.trophyIndex = index;
}

// ModCallback.POST_UPDATE (1)
export function postUpdate(): void {
  checkTouch();
}

function checkTouch() {
  // Don't check anything if we have already finished the race / speedrun.
  if (g.raceVars.finished || speedrunIsFinished()) {
    return;
  }

  // We cannot perform this check in the NPCUpdate callback since it will not fire during the
  // "Appear" animation.
  const trophies = getEntities(EntityTypeCustom.RACE_TROPHY);
  for (const trophy of trophies) {
    const playersInRange = Isaac.FindInRadius(
      trophy.Position,
      TROPHY_TOUCH_DISTANCE,
      EntityPartition.PLAYER,
    );
    for (const entity of playersInRange) {
      const player = entity.ToPlayer();

      // Players should not be able to finish the race if they died at the same time as defeating
      // the boss.
      if (player !== undefined && !player.IsDead() && !isSeededDeathActive()) {
        touch(trophy, player);
        return;
      }
    }
  }
}

function touch(entity: Entity, player: EntityPlayer) {
  if (v.level.trophyIndex === null) {
    logError("A trophy was touched without the index being present.");
    entity.Remove();
  } else {
    mod.removePersistentEntity(v.level.trophyIndex);
    v.level.trophyIndex = null;
  }

  // Make the player pick it up and have it sparkle.
  player.AnimateCollectible(
    CollectibleTypeCustom.TROPHY,
    PlayerItemAnimation.PICKUP,
    // We use a custom "PlayerPickupSparkle" animation so that the sparkle appears higher. (The
    // trophy is taller than a normal collectible, so the sparkle is misaligned.)
    "PlayerPickupSparkle2" as CollectibleAnimation,
  );

  if (speedrun.inSpeedrun()) {
    speedrun.finish(player);
  } else {
    raceFinish();
  }
}

export function doesTrophyExist(): boolean {
  return doesEntityExist(EntityTypeCustom.RACE_TROPHY);
}
