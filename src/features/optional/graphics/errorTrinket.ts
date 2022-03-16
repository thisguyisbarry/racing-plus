import { setCollectibleSprite } from "isaacscript-common";
import { config } from "../../../modConfigMenu";

const CUSTOM_PNG_PATH = "gfx/items/trinkets/trinket_075_error_custom.png";

// ModCallbacks.MC_POST_PICKUP_INIT (34)
// PickupVariant.PICKUP_TRINKET (350)
export function postPickupInitTrinket(pickup: EntityPickup): void {
  if (!config.errorTrinket) {
    return;
  }

  if (pickup.SubType === TrinketType.TRINKET_ERROR) {
    setCollectibleSprite(pickup, CUSTOM_PNG_PATH);
  }
}
