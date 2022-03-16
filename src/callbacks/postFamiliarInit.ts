import { FamiliarVariantCustom } from "../enums/FamiliarVariantCustom";
import * as sb from "../features/items/sawblade";
import * as pc from "../features/optional/graphics/paschalCandle";

export function init(mod: Mod): void {
  mod.AddCallback(
    ModCallbacks.MC_FAMILIAR_INIT,
    paschalCandle,
    FamiliarVariant.PASCHAL_CANDLE, // 221
  );

  mod.AddCallback(
    ModCallbacks.MC_FAMILIAR_INIT,
    sawblade,
    FamiliarVariantCustom.SAWBLADE,
  );
}

// FamiliarVariant.PASCHAL_CANDLE (221)
function paschalCandle(familiar: EntityFamiliar) {
  pc.postFamiliarInitPaschalCandle(familiar);
}

// FamiliarVariantCustom.SAWBLADE
function sawblade(familiar: EntityFamiliar) {
  sb.postFamiliarInitSawblade(familiar);
}
