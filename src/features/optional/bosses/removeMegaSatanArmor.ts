import { DamageFlag } from "isaac-typescript-definitions";
import { config } from "../../../modConfigMenu";

let dealingManualDamage = false;

// ModCallback.ENTITY_TAKE_DMG (11)
// EntityType.MEGA_SATAN_2 (275)
export function entityTakeDmgMegaSatan2(
  entity: Entity,
  amount: float,
  damageFlags: BitFlags<DamageFlag>,
  source: EntityRef,
  countdownFrames: int,
): boolean | undefined {
  if (!config.removeMegaSatanArmor) {
    return;
  }

  if (dealingManualDamage) {
    return;
  }

  dealingManualDamage = true;
  entity.TakeDamage(amount, damageFlags, source, countdownFrames);
  dealingManualDamage = false;

  return false;
}