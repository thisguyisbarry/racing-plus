// Racing+ removes the font that displays the in-game time
// Thus, we need to create a substitute for this
// By holding the map button, players can show a timer that represents the current time spent on
// this specific run
// Unlike the normal run timer, this uses real time instead of game frame count

import g from "../../globals";
import { isActionPressedOnAnyInput } from "../../misc";
import * as timer from "../../timer";
import { TimerType } from "../../timer";

// ModCallbacks.MC_POST_UPDATE (1)
export function postUpdate(): void {
  checkStartTimer();
}

function checkStartTimer() {
  if (g.run.startedTime === 0) {
    g.run.startedTime = Isaac.GetTime();
  }
}

// ModCallbacks.MC_POST_RENDER (2)
export function postRender(): void {
  checkDisplay();
}

export function checkDisplay(): void {
  if (!isActionPressedOnAnyInput(ButtonAction.ACTION_MAP)) {
    return;
  }

  if (g.seeds.HasSeedEffect(SeedEffect.SEED_NO_HUD)) {
    return;
  }

  // Don't show it if we have identified a lot of pills, since it will overlap with the pill UI
  if (g.run.pills.length >= 11) {
    return;
  }

  // Find out how much time has passed since the run started
  let elapsedTime;
  if (g.run.startedTime === 0) {
    // We are currently fading in at the beginning of a run
    elapsedTime = 0;
  } else {
    elapsedTime = Isaac.GetTime() - g.run.startedTime;
  }
  const seconds = elapsedTime / 1000; // elapsedTime is in milliseconds

  const startingX = 52;
  const startingY = 41;

  timer.display(TimerType.RunRealTime, seconds, startingX, startingY);
}
