import { config } from "../../../../../modConfigMenu";
import * as crawlspace from "../crawlspace";

export default function fastTravelPostPlayerUpdate(player: EntityPlayer): void {
  if (!config.fastTravel) {
    return;
  }

  crawlspace.postPlayerUpdate(player);
}