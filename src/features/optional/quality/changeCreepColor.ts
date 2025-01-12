import {
  CollectibleType,
  EntityType,
  FamiliarVariant,
} from "isaac-typescript-definitions";
import { asNumber, copyColor } from "isaacscript-common";
import { config } from "../../../modConfigMenu";

// ModCallback.EVALUATE_CACHE (8)
// CacheFlag.TEAR_COLOR (1 << 6)
export function evaluateCacheTearColor(player: EntityPlayer): void {
  if (!config.changeCreepColor) {
    return;
  }

  changeMysteriousLiquidColor(player);
}

function changeMysteriousLiquidColor(player: EntityPlayer) {
  if (!player.HasCollectible(CollectibleType.MYSTERIOUS_LIQUID)) {
    return;
  }

  // After taking Mysterious Liquid, the color values are all equal to 1.0 except for BO, which is
  // equal to 0.2. Start by coping the existing color and then swap the green and blue values.
  const color = player.TearColor;
  player.TearColor = Color(
    color.R,
    color.G,
    color.B,
    color.A,
    color.RO,
    color.GO - 0.2,
    color.BO + 0.2,
  );
}

// ModCallback.POST_EFFECT_INIT (54)
// EffectVariant.PLAYER_CREEP_GREEN (53)
export function postEffectInitPlayerCreepGreen(effect: EntityEffect): void {
  if (!config.changeCreepColor) {
    return;
  }

  changeGreenCreepToBlue(effect);
}

/**
 * This has to be done on every update frame in order for it to work properly, so we cannot use
 * `POST_EFFECT_INIT` or `POST_EFFECT_INIT_LATE`.
 */
function changeGreenCreepToBlue(effect: EntityEffect) {
  // Ignore creep generated from Lil Spewer.
  if (
    effect.SpawnerType === EntityType.FAMILIAR &&
    effect.SpawnerVariant === asNumber(FamiliarVariant.LIL_SPEWER)
  ) {
    return;
  }

  const sprite = effect.GetSprite();

  // We can't call the `SetColorize` method on the existing color object, so create a new one.
  const newColor = copyColor(sprite.Color);

  // Set the color to blue. (These values were determined through trial and error.)
  newColor.SetColorize(0, 0, 255, 1);
  sprite.Color = newColor;
}

// ModCallback.POST_EFFECT_UPDATE (55)
// EffectVariant.CREEP_RED (22)
export function postEffectUpdateCreepRed(effect: EntityEffect): void {
  if (!config.changeCreepColor) {
    return;
  }

  changeRedCreepToGreen(effect);
}

/**
 * This has to be done on every update frame in order for it to work properly, so we cannot use
 * `POST_EFFECT_INIT` or `POST_EFFECT_INIT_LATE`.
 */
function changeRedCreepToGreen(effect: EntityEffect) {
  const sprite = effect.GetSprite();

  // We can't call the `SetColorize` method on the existing color object, so create a new one.
  const newColor = copyColor(sprite.Color);

  // Set the color to green. These values were determined through trial and error to make creep that
  // looks roughly similar to green creep (from e.g. Pestilence).
  newColor.SetColorize(0, 2.9, 0, 1);
  sprite.Color = newColor;
}

// ModCallback.POST_EFFECT_UPDATE (55)
// EffectVariant.PLAYER_CREEP_RED (46)
export function postEffectUpdatePlayerCreepRed(effect: EntityEffect): void {
  if (!config.changeCreepColor) {
    return;
  }

  // Some green creep uses `EffectVariant.PLAYER_CREEP_RED` for some reason. When this happens, the
  // `R` color value is always 0.0. This check can only be done in the update callback, since on
  // init the `R` value is 1.0.
  const color = effect.GetColor();
  if (color.R === 0) {
    changeRedCreepToBlue(effect);
  }
}

function changeRedCreepToBlue(effect: EntityEffect) {
  const sprite = effect.GetSprite();

  // We can't call the `SetColorize` method on the existing color object, so create a new one.
  const newColor = copyColor(sprite.Color);

  // Set the color to blue. (These values were determined through trial and error.)
  newColor.SetColorize(0, 0, 255, 1);
  sprite.Color = newColor;
}
