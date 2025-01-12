import { CollectibleType, RoomType } from "isaac-typescript-definitions";
import {
  getPlayerFromIndex,
  GRID_INDEX_CENTER_OF_1X1_ROOM,
  isJacobOrEsau,
  removeGridEntity,
} from "isaacscript-common";
import { SeededDeathState } from "../../../../enums/SeededDeathState";
import g from "../../../../globals";
import { mod } from "../../../../mod";
import {
  SEEDED_DEATH_DEBUFF_RENDER_FRAMES,
  SEEDED_DEATH_FEATURE_NAME,
} from "../constants";
import {
  applySeededGhostFade,
  shouldSeededDeathFeatureApply,
} from "../seededDeath";
import { debuffOn, setCheckpointCollision } from "../seededDeathDebuff";
import v from "../v";

export function seededDeathPostNewRoom(): void {
  if (!shouldSeededDeathFeatureApply()) {
    return;
  }

  // Handle seeded death states.
  postNewRoomWaitingForPostCustomRevive();
  postNewRoomGhostForm();
}

function postNewRoomWaitingForPostCustomRevive() {
  if (v.run.state !== SeededDeathState.WAITING_FOR_POST_CUSTOM_REVIVE) {
    return;
  }

  if (v.run.dyingPlayerIndex === null) {
    return;
  }

  const player = getPlayerFromIndex(v.run.dyingPlayerIndex);
  if (player === undefined) {
    return;
  }

  // It is possible to perform a room transition before the player has actually died (e.g. if they
  // die via running into a Curse Room door at full speed). However, we don't need to handle this
  // case, since the death animation will happen immediately after the new room is entered (and
  // during this time, the player is not able to move).
  if (player.HasCollectible(CollectibleType.ONE_UP)) {
    return;
  }

  playAppearAnimationAndFade(player);

  debuffOn(player);
  v.run.debuffEndFrame =
    Isaac.GetFrameCount() + SEEDED_DEATH_DEBUFF_RENDER_FRAMES;
}

export function playAppearAnimationAndFade(player: EntityPlayer): void {
  mod.disableAllInputs(SEEDED_DEATH_FEATURE_NAME);
  applySeededGhostFade(player, true);

  // Play the animation where Isaac lies in the fetal position.
  player.PlayExtraAnimation("AppearVanilla");
  if (isJacobOrEsau(player)) {
    const twin = player.GetOtherTwin();
    if (twin !== undefined) {
      twin.PlayExtraAnimation("AppearVanilla");
      debuffOn(twin);
    }
  }
}

function postNewRoomGhostForm() {
  if (v.run.state !== SeededDeathState.GHOST_FORM) {
    return;
  }

  removeSpikesInSacrificeRoom();
  setCheckpointCollision(false);
}

function removeSpikesInSacrificeRoom() {
  // Prevent people from abusing the death mechanic to use a Sacrifice Room.
  const roomType = g.r.GetType();
  const player = Isaac.GetPlayer();

  if (roomType !== RoomType.SACRIFICE) {
    return;
  }

  const spikes = g.r.GetGridEntity(GRID_INDEX_CENTER_OF_1X1_ROOM);
  if (spikes !== undefined) {
    removeGridEntity(spikes, false);
  }

  player.AnimateSad();
  if (isJacobOrEsau(player)) {
    const twin = player.GetOtherTwin();
    if (twin !== undefined) {
      twin.AnimateSad();
    }
  }
}
