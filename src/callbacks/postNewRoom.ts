import * as cache from "../cache";
import * as controlsGraphic from "../features/mandatory/controlsGraphic";
import * as detectSlideAnimation from "../features/mandatory/detectSlideAnimation";
import * as removeMercurius from "../features/mandatory/removeMercurius";
import * as trophy from "../features/mandatory/trophy";
import * as fastSatan from "../features/optional/bosses/fastSatan";
import * as teleportInvalidEntrance from "../features/optional/bugfix/teleportInvalidEntrance";
import * as appearHands from "../features/optional/enemies/appearHands";
import * as fastTravelPostNewRoom from "../features/optional/major/fastTravel/callbacks/postNewRoom";
import * as freeDevilItem from "../features/optional/major/freeDevilItem";
import * as startWithD6 from "../features/optional/major/startWithD6";
import * as showDreamCatcherItemPostNewRoom from "../features/optional/quality/showDreamCatcherItem/postNewRoom";
import * as showEdenStartingItems from "../features/optional/quality/showEdenStartingItems";
import * as subvertTeleport from "../features/optional/quality/subvertTeleport";
import * as racePostNewRoom from "../features/race/callbacks/postNewRoom";
import g from "../globals";
import log from "../log";
import GlobalsRunRoom from "../types/GlobalsRunRoom";

export function main(): void {
  cache.updateAPIFunctions();

  const gameFrameCount = g.g.GetFrameCount();
  const stage = g.l.GetStage();
  const stageType = g.l.GetStageType();
  const roomDesc = g.l.GetCurrentRoomDesc();
  const roomData = roomDesc.Data;
  const roomStageID = roomData.StageID;
  const roomVariant = roomData.Variant;

  log(
    `MC_POST_NEW_ROOM - ${roomStageID}.${roomVariant} (on stage ${stage}.${stageType}) (game frame ${gameFrameCount})`,
  );

  // Make sure the callbacks run in the right order
  // (naturally, PostNewRoom gets called before the PostNewLevel and PostGameStarted callbacks)
  if (
    (gameFrameCount === 0 ||
      g.run.level.stage !== stage ||
      g.run.level.stageType !== stageType) &&
    !g.run.forceNextRoom
  ) {
    return;
  }
  g.run.forceNextRoom = false;

  newRoom();
}

export function newRoom(): void {
  const gameFrameCount = g.g.GetFrameCount();
  const stage = g.l.GetStage();
  const stageType = g.l.GetStageType();
  const roomDesc = g.l.GetCurrentRoomDesc();
  const roomData = roomDesc.Data;
  const roomStageID = roomData.StageID;
  const roomVariant = roomData.Variant;
  const isClear = g.r.IsClear();

  log(
    `MC_POST_NEW_ROOM_2 - ${roomStageID}.${roomVariant} (on stage ${stage}.${stageType}) (game frame ${gameFrameCount})`,
  );

  // Set variables
  g.run.room = new GlobalsRunRoom(isClear);
  g.run.roomsEntered += 1; // Keep track of how many rooms we enter over the course of the run

  // Mandatory features
  removeMercurius.postNewRoom();
  detectSlideAnimation.postNewRoom();
  controlsGraphic.postNewRoom();

  // Major features
  racePostNewRoom.main();
  trophy.postNewRoom();
  startWithD6.postNewRoom();
  freeDevilItem.postNewRoom();
  fastTravelPostNewRoom.main();

  // Character changes
  showEdenStartingItems.postNewRoom();

  // Enemy changes
  fastSatan.postNewRoom();
  appearHands.postNewRoom();

  // Quality of life
  showDreamCatcherItemPostNewRoom.main();
  subvertTeleport.postNewRoom();

  // Bux fixes
  teleportInvalidEntrance.postNewRoom();
}
