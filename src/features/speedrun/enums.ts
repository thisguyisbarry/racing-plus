export const SEASON_1_NAME = "R+7 (Season 1)";
export const CHANGE_CHAR_ORDER_NAME = "Change Char Order";

export enum ChallengeCustom {
  SEASON_1 = Isaac.GetChallengeIdByName(SEASON_1_NAME),
  CHANGE_CHAR_ORDER = Isaac.GetChallengeIdByName(CHANGE_CHAR_ORDER_NAME),
}

/*
export enum ChangeCharOrderPhase {
  SeasonSelect,
  CharacterSelect,
}
*/
