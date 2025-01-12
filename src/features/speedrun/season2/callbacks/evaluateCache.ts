import { CollectibleType } from "isaac-typescript-definitions";
import {
  copySet,
  hasFlyingTransformation,
  isFlyingCharacter,
} from "isaacscript-common";
import { ChallengeCustom } from "../../../../enums/ChallengeCustom";
import { mod } from "../../../../mod";
import { SEASON_2_STARTING_BUILDS } from "../constants";
import { season2GetCurrentBuildIndex } from "../v";

// CacheFlag.FLYING (1 << 7)
export function season2EvaluateCacheFlying(player: EntityPlayer): void {
  const challenge = Isaac.GetChallenge();
  if (challenge !== ChallengeCustom.SEASON_2) {
    return;
  }

  const buildIndex = season2GetCurrentBuildIndex();
  if (buildIndex === undefined) {
    return;
  }

  const build = SEASON_2_STARTING_BUILDS[buildIndex];
  if (build === undefined) {
    return;
  }

  const firstCollectibleType = build[0];
  if (firstCollectibleType !== CollectibleType.REVELATION) {
    return;
  }

  // Only remove the flight if the player does not have another flight item or effect.
  if (
    !isFlyingCharacter(player) &&
    !hasFlyingTransformation(player) &&
    !mod.hasFlyingTemporaryEffect(player) &&
    !hasFlyingCollectibleExceptForRevelation(player)
  ) {
    player.CanFly = false;
  }
}

function hasFlyingCollectibleExceptForRevelation(player: EntityPlayer) {
  const flyingCollectibles = copySet(mod.getFlyingCollectibles(true));
  flyingCollectibles.delete(CollectibleType.REVELATION);

  for (const collectibleType of flyingCollectibles.values()) {
    if (player.HasCollectible(collectibleType)) {
      return true;
    }
  }

  return false;
}
