import { ItLivesSituation } from "../../../enums/ItLivesSituation";
import {
  season3HasBlueBabyGoal,
  season3HasLambGoal,
  season3HasMegaSatanGoal,
} from "./v";

export function season3PostItLivesPath(): ItLivesSituation {
  if (season3HasMegaSatanGoal()) {
    return ItLivesSituation.BOTH;
  }

  const hasBlueBaby = season3HasBlueBabyGoal();
  const hasLamb = season3HasLambGoal();

  if (hasBlueBaby && hasLamb) {
    return ItLivesSituation.BOTH;
  }

  if (hasBlueBaby) {
    return ItLivesSituation.HEAVEN_DOOR;
  }

  if (hasLamb) {
    return ItLivesSituation.TRAPDOOR;
  }

  return ItLivesSituation.NEITHER;
}
