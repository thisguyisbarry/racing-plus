import {
  EntityType,
  GameStateFlag,
  LevelStage,
  RoomType,
} from "isaac-typescript-definitions";
import {
  game,
  getRoomGridIndex,
  isRoomInsideGrid,
  onRepentanceStage,
  removeAllCollectibles,
  removeAllRocks,
  spawnNPC,
  spawnTeleporter,
} from "isaacscript-common";
import { ChallengeCustom } from "../../../../enums/ChallengeCustom";
import g from "../../../../globals";
import { getNumRoomsEntered } from "../../../utils/numRoomsEntered";
import { isOnFirstCharacter } from "../../speedrun";
import { Season3Goal } from "../constants";
import { resetSeason3StartingRoomSprites } from "../startingRoomSprites";
import v from "../v";

const LEFT_OF_CENTER_GRID_INDEX = 65;
const TOP_CENTER_GRID_INDEX = 22;

export function season3PostNewRoom(): void {
  const challenge = Isaac.GetChallenge();

  if (challenge !== ChallengeCustom.SEASON_3) {
    return;
  }

  const numRoomsEntered = getNumRoomsEntered();
  if (numRoomsEntered !== 1) {
    resetSeason3StartingRoomSprites();
  }

  checkSpawnMegaSatanTeleporter();
  checkDadsNoteRoom();
}

function checkSpawnMegaSatanTeleporter() {
  const stage = g.l.GetStage();
  const isFirstVisit = g.r.IsFirstVisit();
  const startingRoomGridIndex = g.l.GetStartingRoomIndex();
  const roomGridIndex = getRoomGridIndex();

  if (
    stage === LevelStage.DARK_ROOM_CHEST &&
    roomGridIndex === startingRoomGridIndex &&
    isFirstVisit &&
    v.persistent.remainingGoals.includes(Season3Goal.MEGA_SATAN) &&
    !isOnFirstCharacter()
  ) {
    spawnTeleporter(TOP_CENTER_GRID_INDEX);
    v.room.megaSatanTeleporterSpawned = true;
  }
}

function checkDadsNoteRoom() {
  const backwardsPathInit = game.GetStateFlag(
    GameStateFlag.BACKWARDS_PATH_INIT,
  );
  const stage = g.l.GetStage();
  const roomType = g.r.GetType();
  const repentanceStage = onRepentanceStage();
  const roomInsideGrid = isRoomInsideGrid();

  if (
    !v.run.killedDogma &&
    v.persistent.remainingGoals.includes(Season3Goal.DOGMA) &&
    stage === LevelStage.DEPTHS_2 &&
    repentanceStage &&
    roomType === RoomType.BOSS &&
    roomInsideGrid &&
    backwardsPathInit
  ) {
    removeAllCollectibles(); // Remove Dad's Note.

    // We can't spawn Dogma in the center of the room, because then it will overlap with the TV and
    // will glitch out on the next frame.
    const position = g.r.GetGridPosition(LEFT_OF_CENTER_GRID_INDEX);
    spawnNPC(EntityType.DOGMA, 0, 0, position);

    // The Dad's Note room will always have rocks in each of the four corners. Their presence makes
    // the fight a lot harder, so remove them.
    removeAllRocks();
  }
}
