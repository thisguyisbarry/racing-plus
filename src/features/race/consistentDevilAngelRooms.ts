// In seeded races, players will get either all Devil Rooms or all Angel Rooms, with a 50% chance
// of each based on the starting seed of the run
// This is accomplished by using the "Level.InitializeDevilAngelRoom" method to pre-initialize the
// room at the beginning of the floor
// The one bug to worry about is when one player has 33.8% + 33.8% versus 67.8% + 0% chances for
// Devil Rooms and Angel Rooms respectively
// In this situation, one player can get a deal while the other can't
// To work around this, always use the `Game.AddDevilRoomDeal` method at the beginning of a run to
// ensure that the Angel Room chance for players remains at 0
// This works even for the situation where the run is locked into having Angel Rooms, although the
// UI will report the wrong percentages

import { anyPlayerIs, game, getRandom } from "isaacscript-common";
import g from "../../globals";
import v, { inSeededRace } from "./v";

const CHARACTERS_THAT_ALWAYS_GET_ANGEL_ROOMS: readonly PlayerType[] = [
  PlayerType.PLAYER_BETHANY,
  PlayerType.PLAYER_MAGDALENE_B,
];

// ModCallbacks.MC_POST_GAME_STARTED (15)
export function postGameStarted(): void {
  if (!shouldConsistentDevilAngelRoomsApply()) {
    return;
  }

  // Calculate whether we should get all Devil Rooms or all Angel Rooms
  const startSeed = g.seeds.GetStartSeed();
  const startSeedString = g.seeds.GetStartSeedString();
  Isaac.DebugString(`GETTING HERE - startSeed (int): ${startSeed}`);
  Isaac.DebugString(`GETTING HERE - startSeed (string): ${startSeedString}`);
  const randomChance = getRandom(startSeed);
  Isaac.DebugString(`GETTING HERE - randomChance: ${randomChance}`);
  let devil = randomChance < 0.5;
  if (anyPlayerIs(...CHARACTERS_THAT_ALWAYS_GET_ANGEL_ROOMS)) {
    devil = false;
  }
  Isaac.DebugString(`GETTING HERE - devil: ${devil}`);
  v.run.allAngelRooms = !devil;

  // Set the player's vanilla Angel Room chances to 0%
  // (see above explanation)
  game.AddDevilRoomDeal();
}

// ModCallbacks.MC_POST_NEW_LEVEL (18)
export function postNewLevel(): void {
  if (!shouldConsistentDevilAngelRoomsApply()) {
    return;
  }

  if (v.run.allAngelRooms) {
    g.l.InitializeDevilAngelRoom(true, false);
  } else {
    g.l.InitializeDevilAngelRoom(false, true);
  }
}

export function shouldConsistentDevilAngelRoomsApply(): boolean {
  // This mechanic should not apply to Ranked Solo runs
  return inSeededRace() && !(g.race.ranked && g.race.solo);
}

export function inSeededRaceWithAllAngelRooms(): boolean {
  return v.run.allAngelRooms;
}
