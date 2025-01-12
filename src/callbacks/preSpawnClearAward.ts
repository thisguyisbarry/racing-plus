import { ModCallback } from "isaac-typescript-definitions";
import * as seededDrops from "../features/mandatory/seededDrops";
import * as removeStrayPitfalls from "../features/optional/enemies/removeStrayPitfalls";
import { fastTravelPreSpawnClearAward } from "../features/optional/major/fastTravel/callbacks/preSpawnClearAward";
import * as combinedDualityDoors from "../features/optional/quality/combinedDualityDoors";
import * as fastVanishingTwin from "../features/optional/quality/fastVanishingTwin";
import { racePreSpawnClearAward } from "../features/race/callbacks/preSpawnClearAward";
import { speedrunPreSpawnClearAward } from "../features/speedrun/callbacks/preSpawnClearAward";
import { mod } from "../mod";

export function init(): void {
  mod.AddCallback(ModCallback.PRE_SPAWN_CLEAN_AWARD, main);
}

function main(_rng: RNG, _spawnPosition: Vector): boolean | undefined {
  // Major
  fastTravelPreSpawnClearAward();
  racePreSpawnClearAward();
  speedrunPreSpawnClearAward();

  // Enemies
  removeStrayPitfalls.preSpawnClearAward();

  // QoL
  fastVanishingTwin.preSpawnClearAward();

  // Gameplay
  combinedDualityDoors.preSpawnClearAward();

  return seededDrops.preSpawnClearAward();
}
