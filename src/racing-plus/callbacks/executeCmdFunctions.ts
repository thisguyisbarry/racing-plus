import {
  getPlayers,
  getRoomIndex,
  gridToPos,
  log,
  saveDataManagerSave,
} from "isaacscript-common";
import CARD_MAP from "../cardMap";
import CHARACTER_MAP from "../characterMap";
import { VERSION } from "../constants";
import debugFunction from "../debugFunction";
import { setCharacterOrderDebug } from "../features/changeCharOrder/v";
import * as debugPowers from "../features/mandatory/debugPowers";
import * as socketClient from "../features/race/socketClient";
import { ChallengeCustom } from "../features/speedrun/enums";
import { speedrunSetNext } from "../features/speedrun/v";
import g from "../globals";
import PILL_MAP from "../pillMap";
import { consoleCommand, restartAsCharacter } from "../util";
import { unseed } from "../utilGlobals";
import {
  angel,
  blackMarket,
  chaosCardTears,
  commands,
  crawlspace,
  devil,
  goldenBomb,
  goldenKey,
  IAMERROR,
  movePlayer,
  trapdoor,
  validateNumber,
} from "./executeCmdSubroutines";

const functionMap = new Map<string, (params: string) => void>();
export default functionMap;

functionMap.set("angel", (params: string) => {
  angel(params);
});

// cspell:disable-next-line
functionMap.set("blackmarket", (_params: string) => {
  blackMarket();
});

functionMap.set("bomb", (params: string) => {
  let bombs = 1;
  if (params !== "") {
    const num = validateNumber(params);
    if (num !== undefined) {
      bombs = num;
    }
  }

  const player = Isaac.GetPlayer();
  if (player !== undefined) {
    player.AddBombs(bombs);
  }
});

functionMap.set("bombs", (_params: string) => {
  const player = Isaac.GetPlayer();
  if (player !== undefined) {
    player.AddBombs(99);
  }
});

functionMap.set("boss", (_params: string) => {
  const player = Isaac.GetPlayer();
  if (player !== undefined) {
    player.UseCard(Card.CARD_EMPEROR);
  }
});

functionMap.set("bm", (_params: string) => {
  blackMarket();
});

functionMap.set("card", (params: string) => {
  if (params === "") {
    print("You must specify a card name or number.");
    return;
  }

  const num = tonumber(params);
  if (num !== undefined) {
    // Validate the card ID
    if (num < 1 || num >= Card.NUM_CARDS) {
      print("That is an invalid card ID.");
      return;
    }

    // They entered a number instead of a name, so just give the card corresponding to this number
    consoleCommand(`g k${num}`);
    print(`Gave card: #${num}`);
    return;
  }

  const word = params.toLowerCase();
  const card = CARD_MAP.get(word);
  if (card === undefined) {
    print("Unknown card.");
    return;
  }
  consoleCommand(`g k${card}`);
  print(`Gave card: #${card}`);
});

functionMap.set("cards", (_params: string) => {
  let cardNum = 1;
  for (let y = 0; y <= 6; y++) {
    for (let x = 0; x <= 12; x++) {
      if (cardNum === Card.NUM_CARDS) {
        return;
      }

      const position = gridToPos(x, y);
      Isaac.Spawn(
        EntityType.ENTITY_PICKUP,
        PickupVariant.PICKUP_TAROTCARD,
        cardNum,
        position,
        Vector.Zero,
        undefined,
      );
      cardNum += 1;
    }
  }
});

functionMap.set("cc", (_params: string) => {
  chaosCardTears();
});

functionMap.set("changechar", (_params: string) => {
  consoleCommand(`challenge ${ChallengeCustom.CHANGE_CHAR_ORDER}`);
});

functionMap.set("chaos", (_params: string) => {
  chaosCardTears();
});

functionMap.set("char", (params: string) => {
  if (params === "") {
    print("You must specify a character name or number.");
    return;
  }

  let character: PlayerType;
  const num = tonumber(params);
  if (num !== undefined) {
    character = num;
  } else {
    const word = params.toLowerCase();
    const characterFromMap = CHARACTER_MAP.get(word);
    if (characterFromMap === undefined) {
      print("Unknown character.");
      return;
    }
    character = characterFromMap;
  }

  restartAsCharacter(character);
  print(`Restarting as character: ${character}`);
});

functionMap.set("coin", (params: string) => {
  let coins = 1;
  if (params !== "") {
    const num = validateNumber(params);
    if (num !== undefined) {
      coins = num;
    }
  }

  const player = Isaac.GetPlayer();
  if (player !== undefined) {
    player.AddCoins(coins);
  }
});

functionMap.set("coins", (_params: string) => {
  const player = Isaac.GetPlayer();
  if (player !== undefined) {
    player.AddCoins(99);
  }
});

functionMap.set("connect", (_params: string) => {
  if (socketClient.connect()) {
    print("Successfully connected.");
  } else {
    print("Failed to connect.");
  }
});

functionMap.set("commands", (_params: string) => {
  commands(functionMap);
});

functionMap.set("crawl", (_params: string) => {
  crawlspace();
});

functionMap.set("crawlspace", (_params: string) => {
  crawlspace();
});

functionMap.set("dd", (params: string) => {
  devil(params);
});

functionMap.set("debug", (_params: string) => {
  print("Executing debug function.");
  debugFunction();
});

functionMap.set("devil", (params: string) => {
  devil(params);
});

functionMap.set("down", (params: string) => {
  movePlayer(params, Direction.DOWN);
});

functionMap.set("fool", (_params: string) => {
  const player = Isaac.GetPlayer();
  if (player !== undefined) {
    player.UseCard(Card.CARD_FOOL);
  }
});

functionMap.set("effects", (_params: string) => {
  const player = Isaac.GetPlayer();
  const effects = player.GetEffects();
  const effectsList = effects.GetEffectsList();
  if (effectsList.Size === 0) {
    print("There are no current temporary effects.");
    return;
  }
  for (let i = 0; i < effectsList.Size; i++) {
    const effect = effectsList.Get(i);
    if (effect !== undefined) {
      log(`${i + 1} - ${effect.Item.Name}`);
    }
  }
  print('Logged the player\'s effects to the "log.txt" file.');
});

functionMap.set("error", (_params: string) => {
  IAMERROR();
});

functionMap.set("goldbomb", (_params: string) => {
  goldenBomb();
});

functionMap.set("goldenbomb", (_params: string) => {
  goldenBomb();
});

functionMap.set("goldenkey", (_params: string) => {
  goldenKey();
});

functionMap.set("goldkey", (_params: string) => {
  goldenKey();
});

functionMap.set("help", (_params: string) => {
  commands(functionMap);
});

functionMap.set("iamerror", (_params: string) => {
  IAMERROR();
});

functionMap.set("key", (params: string) => {
  let keys = 1;
  if (params !== "") {
    const num = validateNumber(params);
    if (num !== undefined) {
      keys = num;
    }
  }

  const player = Isaac.GetPlayer();
  if (player !== undefined) {
    player.AddKeys(keys);
  }
});

functionMap.set("keys", (_params: string) => {
  const player = Isaac.GetPlayer();
  if (player !== undefined) {
    player.AddKeys(99);
  }
});

functionMap.set("list", (_params: string) => {
  // Used to print out all of the entities in the room
  log("Entities in the room:");
  const roomEntities = Isaac.GetRoomEntities();
  for (let i = 0; i < roomEntities.length; i++) {
    const entity = roomEntities[i];

    // Exclude background effects
    if (
      entity.Type === EntityType.ENTITY_EFFECT &&
      (entity.Variant === EffectVariant.TINY_BUG || // 21
        entity.Variant === EffectVariant.WALL_BUG || // 68
        entity.Variant === EffectVariant.FALLING_EMBER || // 87
        entity.Variant === EffectVariant.LIGHT) // 121
    ) {
      continue;
    }

    let debugString = `${i + 1}  - ${entity.Type}.${entity.Variant}.${
      entity.SubType
    }`;

    const bomb = entity.ToBomb();
    if (bomb !== undefined) {
      debugString += " (bomb)";
    }

    const effect = entity.ToEffect();
    if (effect !== undefined) {
      debugString += `.${effect.State} (effect)`;
    }

    const familiar = entity.ToFamiliar();
    if (familiar !== undefined) {
      debugString += `.${familiar.State} (familiar)`;
    }

    const knife = entity.ToKnife();
    if (knife !== undefined) {
      debugString += " (knife)";
    }

    const laser = entity.ToLaser();
    if (laser !== undefined) {
      debugString += " (laser)";
    }

    const npc = entity.ToNPC();
    if (npc !== undefined) {
      debugString += `.${npc.State} (NPC)`;
    }

    const pickup = entity.ToPickup();
    if (pickup !== undefined) {
      debugString += `.${pickup.State} (pickup)`;
    }

    const player = entity.ToPlayer();
    if (player !== undefined) {
      debugString += " (player)";
    }

    const projectile = entity.ToProjectile();
    if (projectile !== undefined) {
      debugString += " (projectile)";
    }

    const tear = entity.ToTear();
    if (tear !== undefined) {
      debugString += " (tear)";
    }

    debugString += ` (InitSeed: ${entity.InitSeed})`;
    log(debugString);
  }
  print('Logged the entities in the room to the "log.txt" file.');
});

functionMap.set("luck", (_params: string) => {
  consoleCommand("debug 9");
});

functionMap.set("move", (_params: string) => {
  const player = Isaac.GetPlayer();

  // Move the player to a specific position
  const oneByOneRoomRightDoorNextToLoadingZone = Vector(593, 280); // 593 works, 593.1 is too far
  player.Position = oneByOneRoomRightDoorNextToLoadingZone;
});

functionMap.set("next", (_params: string) => {
  speedrunSetNext();
});

functionMap.set("pill", (params: string) => {
  if (params === "") {
    print("You must specify a pill name or number.");
    return;
  }

  const num = tonumber(params);
  if (num !== undefined) {
    // Validate the pill ID
    if (num < 1 || num >= PillEffect.NUM_PILL_EFFECTS) {
      print("That is an invalid pill effect ID.");
      return;
    }

    // They entered a number instead of a name, so just give the pill corresponding to this number
    consoleCommand(`g p${num}`);
    print(`Gave pill: #${num}`);
    return;
  }

  const word = params.toLowerCase();
  const pillEffect = PILL_MAP.get(word);
  if (pillEffect === undefined) {
    print("Unknown pill.");
    return;
  }

  consoleCommand(`g p${pillEffect}`);
  print(`Gave pill: #${pillEffect}`);
});

functionMap.set("pills", (_params: string) => {
  let pillColor = 1;
  let horse = false;
  for (let y = 0; y <= 6; y++) {
    for (let x = 0; x <= 12; x++) {
      if (pillColor === PillColor.NUM_PILLS) {
        if (horse) {
          return;
        }
        horse = true;
        pillColor = 1;
      }

      const subType = horse ? pillColor + PillColor.PILL_GIANT_FLAG : pillColor;
      const position = gridToPos(x, y);
      Isaac.Spawn(
        EntityType.ENTITY_PICKUP,
        PickupVariant.PICKUP_PILL,
        subType,
        position,
        Vector.Zero,
        undefined,
      );

      pillColor += 1;
    }
  }
});

functionMap.set("pos", (_params: string) => {
  for (const player of getPlayers()) {
    print(`Player position: (${player.Position.X}, ${player.Position.Y})`);
  }
});

functionMap.set("previous", (_params: string) => {
  speedrunSetNext(true);
});

functionMap.set("roomindex", (_params: string) => {
  const roomIndex = getRoomIndex();
  print(roomIndex);
});

functionMap.set("s", (params: string) => {
  if (params === "") {
    print("You must specify a stage number.");
    return;
  }

  const finalCharacter = params.slice(-1);
  let stageString: string;
  let stageType: string;
  if (
    finalCharacter === "a" ||
    finalCharacter === "b" ||
    finalCharacter === "c" ||
    finalCharacter === "d"
  ) {
    // e.g. "s 11a" for going to The Chest
    stageString = params.charAt(params.length - 2); // The second to last character
    stageType = finalCharacter;
  } else {
    // e.g. "s 11" for going to the Dark Room
    stageString = params;
    stageType = "";
  }

  const stage = validateNumber(stageString);
  if (stage === undefined) {
    return;
  }

  const minStage = 1;
  const maxStage = 13;
  if (stage < minStage || stage > maxStage) {
    print(`Invalid stage number; must be between ${minStage} and ${maxStage}.`);
    return;
  }

  consoleCommand(`stage ${stage}${stageType}`);
});

functionMap.set("s0", (_params: string) => {
  consoleCommand(`challenge ${Challenge.CHALLENGE_NULL}`);
});

functionMap.set("s1", (_params: string) => {
  consoleCommand(`challenge ${ChallengeCustom.SEASON_1}`);
  consoleCommand("setcharorder");
});

functionMap.set("save", (_params: string) => {
  saveDataManagerSave();
  print('Saved variables to the "save#.dat" file.');
});

functionMap.set("setcharorder", (_params: string) => {
  setCharacterOrderDebug();
  g.run.restart = true;
});

functionMap.set("shop", (_params: string) => {
  const player = Isaac.GetPlayer();
  if (player !== undefined) {
    player.UseCard(Card.CARD_HERMIT);
  }
});

functionMap.set("sound", (params: string) => {
  const soundEffect = validateNumber(params);
  if (soundEffect === undefined) {
    return;
  }
  g.sfx.Play(soundEffect);
});

functionMap.set("sounds", (_params: string) => {
  print("Printing out the currently playing sounds to the log.txt.");
  for (let i = 0; i < SoundEffect.NUM_SOUND_EFFECTS; i++) {
    if (g.sfx.IsPlaying(i)) {
      log(`Currently playing sound effect: ${i}`);
    }
  }
});

functionMap.set("spam", (_params: string) => {
  debugPowers.toggleSpam();
});

functionMap.set("speed", (_params: string) => {
  debugPowers.toggleSpeed();
});

functionMap.set("stick", (_params: string) => {
  const seedString = g.seeds.GetStartSeedString();
  consoleCommand(`seed ${seedString}`);
});

functionMap.set("trap", (_params: string) => {
  trapdoor();
});

functionMap.set("trapdoor", (_params: string) => {
  trapdoor();
});

functionMap.set("treasure", (_params: string) => {
  const player = Isaac.GetPlayer();
  if (player !== undefined) {
    player.UseCard(Card.CARD_STARS);
  }
});

functionMap.set("unseed", (_params: string) => {
  unseed();
  consoleCommand("restart");
});

functionMap.set("version", (_params: string) => {
  const msg = `Racing+ version: ${VERSION}`;
  log(msg);
  print(msg);
});