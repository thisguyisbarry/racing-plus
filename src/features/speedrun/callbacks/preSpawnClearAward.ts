import { season2PreSpawnClearAward } from "../season2/callbacks/preSpawnClearAward";
import { season3PreSpawnClearAward } from "../season3/callbacks/preSpawnClearAward";
import { inSpeedrun } from "../speedrun";

export function speedrunPreSpawnClearAward(): void {
  if (!inSpeedrun()) {
    return;
  }

  season2PreSpawnClearAward();
  season3PreSpawnClearAward();
}
