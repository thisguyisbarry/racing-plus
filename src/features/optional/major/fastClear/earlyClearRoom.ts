import {
  getNPCs,
  inBeastRoom,
  inBossRoomOf,
  isAllPressurePlatesPushed,
  log,
  openAllDoors,
} from "isaacscript-common";
import g from "../../../../globals";
import { inBeastDebugRoom } from "../../../../util";
import {
  CREEP_VARIANTS_TO_KILL,
  EARLY_CLEAR_ROOM_TYPE_BLACKLIST,
} from "./constants";
import { checkPostItLivesOrHushPath } from "./postItLivesOrHushPath";
import v from "./v";

// ModCallbacks.MC_POST_UPDATE (1)
export function postUpdate(): void {
  checkEarlyClearRoom();
}

function checkEarlyClearRoom() {
  const gameFrameCount = g.g.GetFrameCount();
  const roomFrameCount = g.r.GetFrameCount();
  const roomType = g.r.GetType();
  const roomClear = g.r.IsClear();

  // Do nothing if we already cleared the room
  if (v.room.earlyClearedRoom) {
    return;
  }

  // Under certain conditions, the room can be clear of enemies on the first frame
  // Thus, the earliest possible frame that fast-clear should apply is on frame 1
  if (roomFrameCount < 1) {
    return;
  }

  // Certain types of rooms are exempt from the fast-clear feature
  if (EARLY_CLEAR_ROOM_TYPE_BLACKLIST.has(roomType)) {
    return;
  }

  // The Great Gideon is exempt from the fast-clear feature
  // (since it can cause the boss item to spawn on a pit from a Rock Explosion)
  if (inBossRoomOf(BossID.GREAT_GIDEON)) {
    return;
  }

  // The Beast fight is exempt from the fast-clear feature
  // (since it will prevent the trophy logic from working correctly)
  if (inBeastRoom() || inBeastDebugRoom()) {
    return;
  }

  // If a frame has passed since an enemy died, reset the delay counter
  if (
    v.room.delayClearUntilFrame !== null &&
    gameFrameCount >= v.room.delayClearUntilFrame
  ) {
    v.room.delayClearUntilFrame = null;
  }

  // Check on every frame to see if we need to open the doors
  if (
    v.room.aliveEnemies.size === 0 &&
    v.room.delayClearUntilFrame === null &&
    !roomClear &&
    isAllPressurePlatesPushed()
  ) {
    earlyClearRoom();
  }
}

function earlyClearRoom() {
  const gameFrameCount = g.g.GetFrameCount();

  v.room.earlyClearedRoom = true;
  log(`Early clearing the room on frame ${gameFrameCount} (fast-clear).`);

  // The "TriggerClear()" method must be before other logic because extra doors can be spawned by
  // clearing the room
  g.r.TriggerClear();
  g.r.SetClear(true);

  openAllDoors();
  killExtraEntities();
  checkPostItLivesOrHushPath();
}

function killExtraEntities() {
  killDeathsHeads();
  killFleshDeathsHeads();
  killCreep();
}

function killDeathsHeads() {
  const deathsHeads = getNPCs(
    EntityType.ENTITY_DEATHS_HEAD,
    undefined,
    undefined,
    true,
  );
  for (const deathsHead of deathsHeads) {
    // Death's Dank Head is a "normal" enemy in that it does not rely on other enemies in the room
    // to be alive
    // (it is the only variant that has this behavior)
    if (deathsHead.Variant === DeathsHeadVariant.DANK_DEATHS_HEAD) {
      continue;
    }

    // Activate the death state
    deathsHead.State = NpcState.STATE_DEATH;
    // (we can't do "deathsHead.Kill()" because then it immediately vanishes)
    deathsHead.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE;
    // (players should be able to run through them as they are dying;
    // this matches the vanilla behavior)
  }
}

function killFleshDeathsHeads() {
  const fleshDeathsHeads = getNPCs(
    EntityType.ENTITY_FLESH_DEATHS_HEAD,
    undefined,
    undefined,
    true,
  );
  for (const fleshDeathsHead of fleshDeathsHeads) {
    // Activating the death state won't make the tears explode out of it,
    // so just kill it and spawn another one, which will immediately die
    fleshDeathsHead.Visible = false;
    fleshDeathsHead.Kill();
    const newHead = g.g
      .Spawn(
        fleshDeathsHead.Type,
        fleshDeathsHead.Variant,
        fleshDeathsHead.Position,
        fleshDeathsHead.Velocity,
        fleshDeathsHead.Parent,
        fleshDeathsHead.SubType,
        fleshDeathsHead.InitSeed,
      )
      .ToNPC();
    if (newHead !== undefined) {
      newHead.State = NpcState.STATE_DEATH;
    }
  }
}

function killCreep() {
  const creepEntities = Isaac.FindByType(
    EntityType.ENTITY_EFFECT,
    -1,
    -1,
    false,
    true,
  );
  for (const entity of creepEntities) {
    if (CREEP_VARIANTS_TO_KILL.has(entity.Variant)) {
      entity.Kill();
    }
  }
}
