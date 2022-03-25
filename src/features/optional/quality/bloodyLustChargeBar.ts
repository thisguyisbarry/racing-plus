import {
  DefaultMap,
  defaultMapGetPlayer,
  mapSetPlayer,
  PlayerIndex,
  saveDataManager,
} from "isaacscript-common";
import {
  drawCustomChargeBar,
  NUM_FRAMES_IN_CHARGING_ANIMATION,
  shouldDrawCustomChargeBar,
} from "../../../customChargeBar";
import { CustomChargeBarType } from "../../../enums/CustomChargeBarType";
import g from "../../../globals";
import { config } from "../../../modConfigMenu";

const MAX_BLOODY_LUST_CHARGES = 6;

const sprite = Sprite();
sprite.Load("gfx/chargebar_bloody_lust.anm2", true);

const v = {
  level: {
    playersNumHits: new DefaultMap<PlayerIndex, int>(0),
  },
};

export function init(): void {
  saveDataManager("bloodyLustChargeBar", v);
}

// ModCallbacks.MC_ENTITY_TAKE_DMG (11)
// EntityType.ENTITY_PLAYER (1)
export function entityTakeDmgPlayer(player: EntityPlayer): void {
  const numHits = defaultMapGetPlayer(v.level.playersNumHits, player);
  const newNumHits = numHits + 1;
  mapSetPlayer(v.level.playersNumHits, player, newNumHits);
}

// ModCallbacks.MC_POST_PLAYER_RENDER (32)
export function postPlayerRender(player: EntityPlayer): void {
  if (!config.bloodyLustChargeBar) {
    return;
  }

  const hud = g.g.GetHUD();
  if (!hud.IsVisible()) {
    return;
  }

  if (!shouldDrawCustomChargeBar(player, CustomChargeBarType.BLOODY_LUST)) {
    return;
  }

  const numHits = defaultMapGetPlayer(v.level.playersNumHits, player);

  const frameAmountPerCharge =
    NUM_FRAMES_IN_CHARGING_ANIMATION / MAX_BLOODY_LUST_CHARGES;
  const frame = Math.round(numHits * frameAmountPerCharge);
  drawCustomChargeBar(player, sprite, frame, CustomChargeBarType.BLOODY_LUST);
}
