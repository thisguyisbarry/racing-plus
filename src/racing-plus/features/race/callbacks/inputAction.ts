import g from "../../../globals";
import { config } from "../../../modConfigMenu";
import RaceFormat from "../types/RaceFormat";
import RacerStatus from "../types/RacerStatus";
import RaceStatus from "../types/RaceStatus";

// InputHook.IS_ACTION_TRIGGERED (1)
// ButtonAction.ACTION_CONSOLE (28)
export function isActionTriggeredConsole(): boolean | void {
  if (!config.clientCommunication) {
    return undefined;
  }

  if (g.debug) {
    return undefined;
  }

  // Prevent opening the console during a race
  if (
    g.race.status === RaceStatus.IN_PROGRESS &&
    g.race.myStatus === RacerStatus.RACING &&
    g.race.format !== RaceFormat.CUSTOM // Allow usage of the console in custom races
  ) {
    return false;
  }

  return undefined;
}