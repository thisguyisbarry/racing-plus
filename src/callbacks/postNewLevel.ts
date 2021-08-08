import { anyPlayerIs, isRepentanceStage, log } from "isaacscript-common";
import * as streakText from "../features/mandatory/streakText";
import * as tempMoreOptions from "../features/mandatory/tempMoreOptions";
import * as openHushDoor from "../features/optional/quality/openHushDoor";
import * as silenceMomDad from "../features/optional/sound/silenceMomDad";
import racePostNewLevel from "../features/race/callbacks/postNewLevel";
import g from "../globals";

export function main(): void {
  const gameFrameCount = g.g.GetFrameCount();
  const stage = g.l.GetStage();
  const stageType = g.l.GetStageType();

  log(
    `MC_POST_NEW_LEVEL - ${stage}.${stageType} (game frame ${gameFrameCount})`,
  );

  // Other miscellaneous things
  if (shouldShowLevelText()) {
    showLevelText(stage);
  }

  // Mandatory features
  tempMoreOptions.postNewLevel();

  // Major features
  racePostNewLevel();

  // Quality of life
  openHushDoor.postNewLevel();

  // Sounds
  silenceMomDad.postNewLevel();
}

function shouldShowLevelText() {
  const randomBaby = Isaac.GetPlayerTypeByName("Random Baby");

  return (
    // If the race is finished, the "Victory Lap" text will overlap with the stage text,
    // so don't bother showing it
    !g.raceVars.finished &&
    // If one or more players are playing as "Random Baby", the baby descriptions will slightly
    // overlap with the stage text, so don't bother showing it
    !anyPlayerIs(randomBaby)
  );
}

function showLevelText(stage: int) {
  // Show what the new floor is
  // (the game will not show this naturally after doing a "stage" console command)
  if (VanillaStreakText && (stage !== 1 || isRepentanceStage())) {
    g.l.ShowName(false);
  } else if (!goingToRaceRoom()) {
    const text = getLevelText();
    streakText.set(text);
  }
}

function getLevelText() {
  const stage = g.l.GetStage();
  const stageType = g.l.GetStageType();

  if (stage === 9) {
    return "Blue Womb";
  }

  return g.l.GetName(stage, stageType);
}

function goingToRaceRoom() {
  const stage = g.l.GetStage();

  return (
    g.race.status === "open" &&
    stage === 1 &&
    (g.run.roomsEntered === 0 || g.run.roomsEntered === 1)
  );
}
