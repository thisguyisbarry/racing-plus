import {
  DamageFlag,
  EntityType,
  ModCallback,
} from "isaac-typescript-definitions";
import * as doubleAngelNerf from "../features/mandatory/doubleAngelNerf";
import * as dummyDPS from "../features/mandatory/dummyDPS";
import * as removeArmor from "../features/optional/bosses/removeArmor";
import { fastTravelEntityTakeDmgPlayer } from "../features/optional/major/fastTravel/callbacks/entityTakeDmg";
import * as freeDevilItem from "../features/optional/major/freeDevilItem";
import * as roll from "../features/optional/other/roll";
import * as bloodyLustChargeBar from "../features/optional/quality/bloodyLustChargeBar/bloodyLustChargeBar";

export function init(mod: Mod): void {
  mod.AddCallback(
    ModCallback.ENTITY_TAKE_DMG,
    entityTakeDmgPlayer,
    EntityType.PLAYER, // 1
  );

  mod.AddCallback(
    ModCallback.ENTITY_TAKE_DMG,
    uriel,
    EntityType.URIEL, // 271
  );

  mod.AddCallback(
    ModCallback.ENTITY_TAKE_DMG,
    gabriel,
    EntityType.GABRIEL, // 272
  );

  mod.AddCallback(
    ModCallback.ENTITY_TAKE_DMG,
    megaSatan2,
    EntityType.MEGA_SATAN_2, // 275
  );

  mod.AddCallback(
    ModCallback.ENTITY_TAKE_DMG,
    hush,
    EntityType.HUSH, // 407
  );

  mod.AddCallback(
    ModCallback.ENTITY_TAKE_DMG,
    dummy,
    EntityType.DUMMY, // 964
  );
}

function entityTakeDmgPlayer(
  entity: Entity,
  amount: float,
  damageFlags: BitFlags<DamageFlag>,
  _source: EntityRef,
  _countdownFrames: int,
): boolean | undefined {
  const player = entity.ToPlayer();
  if (player === undefined) {
    return undefined;
  }

  // Major
  freeDevilItem.entityTakeDmgPlayer(entity, amount, damageFlags);
  fastTravelEntityTakeDmgPlayer(damageFlags);

  // QoL
  bloodyLustChargeBar.entityTakeDmgPlayer(player);

  // Other
  roll.entityTakeDmgPlayer(player);

  return undefined;
}

// EntityType.URIEL (271)
function uriel(
  _entity: Entity,
  _amount: float,
  _damageFlags: BitFlags<DamageFlag>,
  source: EntityRef,
  _countdownFrames: int,
): boolean | undefined {
  return doubleAngelNerf.entityTakeDmgUriel(source);
}

// EntityType.GABRIEL (272)
function gabriel(
  _entity: Entity,
  _amount: float,
  _damageFlags: BitFlags<DamageFlag>,
  source: EntityRef,
  _countdownFrames: int,
): boolean | undefined {
  return doubleAngelNerf.entityTakeDmgGabriel(source);
}

// EntityType.MEGA_SATAN_2 (275)
function megaSatan2(
  entity: Entity,
  amount: float,
  damageFlags: BitFlags<DamageFlag>,
  source: EntityRef,
  countdownFrames: int,
): boolean | undefined {
  return removeArmor.entityTakeDmgMegaSatan2(
    entity,
    amount,
    damageFlags,
    source,
    countdownFrames,
  );
}

// EntityType.HUSH (407)
function hush(
  entity: Entity,
  amount: float,
  damageFlags: BitFlags<DamageFlag>,
  source: EntityRef,
  countdownFrames: int,
): boolean | undefined {
  return removeArmor.entityTakeDmgHush(
    entity,
    amount,
    damageFlags,
    source,
    countdownFrames,
  );
}

// EntityType.DUMMY (964)
function dummy(
  _entity: Entity,
  amount: float,
  _damageFlags: BitFlags<DamageFlag>,
  _source: EntityRef,
  _countdownFrames: int,
): boolean | undefined {
  return dummyDPS.entityTakeDmgDummy(amount);
}
