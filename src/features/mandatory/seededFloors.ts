// Different inventory and health conditions can affect special room generation
// Different special rooms can also sometimes change the actual room selection of non-special rooms
// This is bad for seeded races; we want to ensure consistent floors
// Thus, we arbitrarily set inventory and health conditions before going to the next floor,
// and then swap them back
// https://bindingofisaacrebirth.gamepedia.com/Level_Generation
// This feature is not configurable because it could change floors, causing a seed to be different
// This feature relies on fast travel to function

import {
  characterCanHaveRedHearts,
  characterGetsBlackHeartFromEternalHeart,
  getPlayerHealth,
  getRandom,
  log,
  newRNG,
  PlayerHealth,
  removeAllPlayerHealth,
  saveDataManager,
  setPlayerHealth,
} from "isaacscript-common";
import g from "../../globals";
import { config } from "../../modConfigMenu";
import { inSeededRace } from "../race/v";

interface GameStateFlags {
  devilVisited: boolean;
  bookTouched: boolean;
}

interface Inventory {
  coins: int;
  bombs: int;
  keys: int;
}

const v = {
  run: {
    gameStateFlags: null as GameStateFlags | null,
    inventory: null as Inventory | null,
    playerHealth: null as PlayerHealth | null,
  },
};

export function init(): void {
  saveDataManager("seededFloors", v, featureEnabled);
}

function featureEnabled() {
  return config.fastTravel;
}

// ModCallbacks.MC_POST_GAME_STARTED (15)
export function postGameStarted(): void {
  // We may have had the Curse of the Unknown seed enabled in a previous run,
  // so ensure that it is removed
  g.seeds.RemoveSeedEffect(SeedEffect.SEED_PERMANENT_CURSE_UNKNOWN);
}

export function before(): void {
  // Only swap things if we are playing on a seeded race
  if (!inSeededRace()) {
    return;
  }

  log("seededFloors - Before going to a new floor.");

  const player = Isaac.GetPlayer();
  const character = player.GetPlayerType();
  const eternalHearts = player.GetEternalHearts();
  const levelSeed = g.l.GetDungeonPlacementSeed();
  const rng = newRNG(levelSeed);

  // Record the current inventory and health values
  v.run.gameStateFlags = getGameStateFlags();
  v.run.inventory = getInventory(player);
  v.run.playerHealth = getPlayerHealth(player);

  // Eternal Hearts will be lost since we are about to change floors,
  // so convert it to other types of health
  // "eternalHearts" will be equal to 1 if we have an Eternal Heart
  if (characterCanHaveRedHearts(character)) {
    v.run.playerHealth.maxHearts += v.run.playerHealth.eternalHearts * 2;
    v.run.playerHealth.hearts += v.run.playerHealth.eternalHearts * 2;
  } else {
    const heartSubType = characterGetsBlackHeartFromEternalHeart(character)
      ? HeartSubType.HEART_BLACK
      : HeartSubType.HEART_SOUL;
    for (let i = 0; i < v.run.playerHealth.eternalHearts; i++) {
      v.run.playerHealth.soulHearts += 2;
      v.run.playerHealth.soulHeartTypes.push(heartSubType);
    }
  }
  v.run.playerHealth.eternalHearts = 0;

  // Modification 1: Devil Room visited
  // "GameStateFlag.STATE_DEVILROOM_VISITED" affects the chances of a Curse Room being generated
  // However, in seeded races, we always start off the player with one Devil Room item taken
  // (for the consistent Devil/Angel room feature)
  // Thus, default to always having this flag set to true, which will result in slightly more Curse
  // Rooms on the first two floors than normal, but that is okay
  g.g.SetStateFlag(GameStateFlag.STATE_DEVILROOM_VISITED, true);

  // Modification 2: Book touched
  const bookMod = getRandom(rng);
  if (bookMod < 0.5) {
    g.g.SetStateFlag(GameStateFlag.STATE_BOOK_PICKED_UP, false);
  } else {
    g.g.SetStateFlag(GameStateFlag.STATE_BOOK_PICKED_UP, true);
  }

  // Modification 3: Coins
  const coinMod = getRandom(rng);
  player.AddCoins(-999);
  if (coinMod < 0.5) {
    // 50% chance to have 5 coins
    // (we give 20 in case Greed's Gullet and empty heart containers)
    player.AddCoins(20);
  }

  // Modification 4: Keys
  const keyMod = getRandom(rng);
  player.AddKeys(-99);
  if (keyMod < 0.5) {
    // 50% chance to get 2 keys
    player.AddKeys(2);
  }

  // Remove all health
  removeAllPlayerHealth(player);

  // Modification 5: Full health
  // (which always applies to characters who cannot have red heart containers)
  if (characterCanHaveRedHearts(character)) {
    player.AddMaxHearts(2, false);
    player.AddHearts(1);
    const fullHealthMod = getRandom(rng);
    if (fullHealthMod < 0.66) {
      // 66% chance to be full health
      player.AddHearts(1);
    }
  } else {
    // Give them one soul heart so that they do not die upon changing floors
    player.AddSoulHearts(2);
  }

  // Modification 6: Critical health
  // (which is defined as being at 1 heart or less)
  const criticalHealthMod = getRandom(rng);
  if (criticalHealthMod < 0.75) {
    // 75% chance to not be at critical health
    if (characterCanHaveRedHearts(character)) {
      player.AddMaxHearts(2, false);
      player.AddHearts(2);
    } else {
      player.AddSoulHearts(2);
    }
  }

  // Add any eternal hearts back so that the giantbook animation is triggered as per normal
  player.AddEternalHearts(eternalHearts);
}

export function after(): void {
  // Only swap things if we are playing on a seeded race
  if (!inSeededRace()) {
    return;
  }

  log("seededFloors - After going to a new floor.");

  const player = Isaac.GetPlayer();

  // Set everything back to the way it was before
  if (v.run.gameStateFlags !== null) {
    setGameStateFlags(v.run.gameStateFlags);
  }
  if (v.run.inventory !== null) {
    setInventory(player, v.run.inventory);
  }
  if (v.run.playerHealth !== null) {
    setPlayerHealth(player, v.run.playerHealth);
  }

  addExtraHealthFromItems(player);
  fixWhoreOfBabylon(player);

  g.seeds.RemoveSeedEffect(SeedEffect.SEED_PERMANENT_CURSE_UNKNOWN);
}

function getGameStateFlags(): GameStateFlags {
  const devilVisited = g.g.GetStateFlag(GameStateFlag.STATE_DEVILROOM_VISITED);
  const bookTouched = g.g.GetStateFlag(GameStateFlag.STATE_BOOK_PICKED_UP);

  return {
    devilVisited,
    bookTouched,
  };
}

function setGameStateFlags(gameStateFlags: GameStateFlags) {
  g.g.SetStateFlag(
    GameStateFlag.STATE_DEVILROOM_VISITED,
    gameStateFlags.devilVisited,
  );
  g.g.SetStateFlag(
    GameStateFlag.STATE_BOOK_PICKED_UP,
    gameStateFlags.bookTouched,
  );
}

function getInventory(player: EntityPlayer): Inventory {
  const coins = player.GetNumCoins();
  const bombs = player.GetNumBombs();
  const keys = player.GetNumKeys();

  return {
    coins,
    bombs,
    keys,
  };
}

function setInventory(player: EntityPlayer, inventory: Inventory) {
  player.AddCoins(-99);
  player.AddCoins(inventory.coins);
  player.AddBombs(-99);
  player.AddBombs(inventory.bombs);
  player.AddKeys(-99);
  player.AddKeys(inventory.keys);
}

function addExtraHealthFromItems(player: EntityPlayer) {
  // 566
  // In vanilla, no matter how many Dream Catchers the player has, it will only grant 1 soul heart
  if (player.HasCollectible(CollectibleType.COLLECTIBLE_DREAM_CATCHER)) {
    player.AddSoulHearts(1);
  }

  // 676
  const redHearts = player.GetHearts();
  if (
    player.HasCollectible(CollectibleType.COLLECTIBLE_EMPTY_HEART) &&
    redHearts <= 2
  ) {
    player.AddMaxHearts(2, true);
  }

  // 55
  const numMaggysFaith = player.GetTrinketMultiplier(
    TrinketType.TRINKET_MAGGYS_FAITH,
  );
  player.AddEternalHearts(numMaggysFaith);

  const numHollowHearts = player.GetTrinketMultiplier(
    TrinketType.TRINKET_HOLLOW_HEART,
  );
  player.AddBoneHearts(numHollowHearts);
}

/** Restoring the player's health can result in a bugged Whore of Babylon state. */
function fixWhoreOfBabylon(player: EntityPlayer) {
  const effects = player.GetEffects();
  const hasWhoreEffect = effects.HasCollectibleEffect(
    CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON,
  );
  const shouldHaveWhoreEffect = shouldWhoreOfBabylonApply(player);

  if (shouldHaveWhoreEffect && !hasWhoreEffect) {
    effects.AddCollectibleEffect(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON);
  } else if (!shouldHaveWhoreEffect && hasWhoreEffect) {
    effects.RemoveCollectibleEffect(
      CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON,
    );
  }
}

function shouldWhoreOfBabylonApply(player: EntityPlayer) {
  const hasWhore = player.HasCollectible(
    CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON,
  );
  const character = player.GetPlayerType();
  const hearts = player.GetHearts();
  const redHeartTriggerAmount = character === PlayerType.PLAYER_EVE ? 2 : 1;

  return hasWhore && hearts <= redHeartTriggerAmount;
}
