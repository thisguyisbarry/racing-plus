import { getRoomIndex } from "isaacscript-common";
import g from "../../../globals";
import { config } from "../../../modConfigMenu";
import { findFreePosition } from "../../../utilGlobals";
import * as trophy from "../../mandatory/trophy";
import * as seededDeath from "../seededDeath";
import RaceGoal from "../types/RaceGoal";
import RacerStatus from "../types/RacerStatus";
import RaceStatus from "../types/RaceStatus";

export default function racePostUpdate(): void {
  if (!config.clientCommunication) {
    return;
  }

  spawnBossRushTrophy();
  seededDeath.postUpdate();
}

function spawnBossRushTrophy() {
  const roomIndex = getRoomIndex();
  const bossRushDone = g.g.GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DONE);

  if (
    !trophy.trophyHasSpawned() &&
    g.race.status === RaceStatus.IN_PROGRESS &&
    g.race.myStatus === RacerStatus.RACING &&
    g.race.goal === RaceGoal.BOSS_RUSH &&
    !g.raceVars.finished &&
    roomIndex === GridRooms.ROOM_BOSSRUSH_IDX &&
    bossRushDone
  ) {
    const centerPos = g.r.GetCenterPos();
    const position = findFreePosition(centerPos); // Some Boss Rush layouts have pits
    trophy.spawn(position);
  }
}
