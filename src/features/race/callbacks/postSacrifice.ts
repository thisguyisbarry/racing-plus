// Prevent racers from using a Sacrifice Room to skip all of the floors on races to The Lamb &
// Mega Satan

import * as preventSacrificeRoomTeleport from "../preventSacrificeRoomTeleport";

export default function racePostSacrifice(
  player: EntityPlayer,
  numSacrifices: int,
): void {
  preventSacrificeRoomTeleport.postSacrifice(player, numSacrifices);
}