/*

Notes:

1) If we want to prevent entities from spawning, we cannot return an entity type of 0, since the
   game will crash. Instead, in most cases we can return an effect with a variant of 0, which is a
   non-interacting invisible thing

2) Sometimes, if you return a type other than the original type (e.g. replacing a pickup with an
   effect), the game will crash. Thus, you should replace a pickup with a blank pickup (as opposed
   to a blank effect)

*/

import { EntityType, ModCallback } from "isaac-typescript-definitions";
import { log } from "isaacscript-common";
import { mod } from "../mod";
import { preEntitySpawnFunctions } from "./preEntitySpawnFunctions";

const DEBUG = false as boolean;

export function init(): void {
  mod.AddCallback(ModCallback.PRE_ENTITY_SPAWN, main);
}

function main(
  entityType: EntityType,
  variant: int,
  subType: int,
  position: Vector,
  _velocity: Vector,
  spawner: Entity | undefined,
  initSeed: int,
): [EntityType, int, int, int] | undefined {
  if (DEBUG) {
    log(
      `MC_PRE_ENTITY_SPAWN - ${entityType}.${variant}.${subType} - ${initSeed}`,
    );
  }

  const preEntityFunction = preEntitySpawnFunctions.get(entityType);
  if (preEntityFunction !== undefined) {
    return preEntityFunction(variant, subType, position, spawner, initSeed);
  }

  return undefined;
}
