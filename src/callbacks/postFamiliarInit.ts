import { FamiliarVariant, ModCallback } from "isaac-typescript-definitions";
import { FamiliarVariantCustom } from "../enums/FamiliarVariantCustom";
import * as sb from "../features/items/sawblade";
import * as pc from "../features/optional/graphics/paschalCandle";
import { mod } from "../mod";

export function init(): void {
  mod.AddCallback(
    ModCallback.POST_FAMILIAR_INIT,
    paschalCandle,
    FamiliarVariant.PASCHAL_CANDLE, // 221
  );

  mod.AddCallback(
    ModCallback.POST_FAMILIAR_INIT,
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
