import {
  drawCustomChargeBar,
  NUM_FRAMES_IN_CHARGING_ANIMATION,
  NUM_ROOMS_TO_CHARGE_AZAZELS_RAGE,
  shouldDrawAnyCustomChargeBar,
  shouldDrawCustomChargeBar,
} from "../../../customChargeBar";
import { CustomChargeBarType } from "../../../enums/CustomChargeBarType";
import { config } from "../../../modConfigMenu";

const sprite = Sprite();
sprite.Load("gfx/chargebar_azazels_rage.anm2", true);

// ModCallbacks.MC_POST_PLAYER_RENDER (32)
export function postPlayerRender(
  player: EntityPlayer,
  renderOffset: Vector,
): void {
  if (!config.azazelsRageChargeBar) {
    return;
  }

  if (!shouldDrawAnyCustomChargeBar(renderOffset)) {
    return;
  }

  if (!shouldDrawCustomChargeBar(player, CustomChargeBarType.AZAZELS_RAGE)) {
    return;
  }

  const effects = player.GetEffects();
  let numCharges = effects.GetCollectibleEffectNum(
    CollectibleType.COLLECTIBLE_AZAZELS_RAGE,
  );

  // The number of effects goes to 6 when the blast is firing
  if (numCharges > 4) {
    numCharges = 0;
  }

  const frameAmountPerCharge =
    NUM_FRAMES_IN_CHARGING_ANIMATION / NUM_ROOMS_TO_CHARGE_AZAZELS_RAGE;
  const frame = Math.round(numCharges * frameAmountPerCharge);
  drawCustomChargeBar(player, sprite, frame, CustomChargeBarType.AZAZELS_RAGE);
}
