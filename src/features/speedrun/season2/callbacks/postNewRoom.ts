import { ChallengeCustom } from "../../../../enums/ChallengeCustom";
import { getNumRoomsEntered } from "../../../utils/numRoomsEntered";
import { resetSeason2StartingRoomSprites } from "../startingRoomSprites";

export function season2PostNewRoom(): void {
  const challenge = Isaac.GetChallenge();

  if (challenge !== ChallengeCustom.SEASON_2) {
    return;
  }

  const numRoomsEntered = getNumRoomsEntered();

  if (numRoomsEntered !== 1) {
    resetSeason2StartingRoomSprites();
  }
}
