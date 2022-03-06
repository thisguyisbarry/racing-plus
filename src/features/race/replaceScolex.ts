// In seeded races, we replace Scolex with two Frails to reduce RNG

import {
  countEntities,
  nextSeed,
  removeAllMatchingEntities,
  repeat,
} from "isaacscript-common";
import g from "../../globals";
import { RaceFormat } from "./types/RaceFormat";
import { RacerStatus } from "./types/RacerStatus";
import { RaceStatus } from "./types/RaceStatus";

const SCOLEX_TYPE = EntityType.ENTITY_PIN;
const SCOLEX_VARIANT = PinVariant.SCOLEX;
const NUM_FRAILS = 2;

// ModCallbacks.MC_POST_NEW_ROOM (19)
export function postNewRoom(): void {
  if (
    g.race.status !== RaceStatus.IN_PROGRESS ||
    g.race.myStatus !== RacerStatus.RACING ||
    g.race.format !== RaceFormat.SEEDED
  ) {
    return;
  }

  const roomClear = g.r.IsClear();
  const roomSeed = g.r.GetSpawnSeed();
  const centerPos = g.r.GetCenterPos();

  if (roomClear) {
    return;
  }

  const numScolexes = countEntities(SCOLEX_TYPE, SCOLEX_VARIANT, -1, true);
  if (numScolexes === 0) {
    return;
  }

  // There are 10 Scolex entities for each Scolex
  removeAllMatchingEntities(SCOLEX_TYPE, SCOLEX_VARIANT);

  let seed = roomSeed;
  repeat(NUM_FRAILS, (i) => {
    // We don't want to spawn both of them on top of each other since that would make them behave
    // a little glitchy
    // Note that pos.X += 200 causes the hitbox to appear too close to the left/right side,
    // causing damage if the player moves into the room too quickly
    let modification: Vector;
    if (i === 0) {
      modification = Vector(-150, 0);
    } else {
      modification = Vector(150, 0);
    }
    const position = centerPos.add(modification);
    seed = nextSeed(seed);
    const frail = g.g.Spawn(
      EntityType.ENTITY_PIN,
      PinVariant.FRAIL,
      position,
      Vector.Zero,
      undefined,
      0,
      seed,
    );

    // It will show the head on the first frame after spawning unless we hide it
    // The game will automatically make the entity visible later on
    frail.Visible = false;
  });
}
