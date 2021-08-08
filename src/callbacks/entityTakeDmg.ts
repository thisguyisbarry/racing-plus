import fastTravelEntityTakeDmgPlayer from "../features/optional/major/fastTravel/callbacks/entityTakeDmg";
import * as freeDevilItem from "../features/optional/major/freeDevilItem";
import * as showNumSacrifices from "../features/optional/quality/showNumSacrifices";

export function init(mod: Mod): void {
  mod.AddCallback(
    ModCallbacks.MC_ENTITY_TAKE_DMG,
    player,
    EntityType.ENTITY_PLAYER, // 1
  );
}

function player(
  tookDamage: Entity,
  _damageAmount: float,
  damageFlags: int,
  _damageSource: EntityRef,
  _damageCountdownFrames: int,
) {
  // Major features
  freeDevilItem.entityTakeDmgPlayer(tookDamage, damageFlags);
  fastTravelEntityTakeDmgPlayer(tookDamage, damageFlags);

  // Quality of life
  showNumSacrifices.entityTakeDmgPlayer(damageFlags);
}
