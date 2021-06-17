// Automatically open the Hush door to speed things up

import g from "../../../globals";

export function postNewLevel(): void {
  if (!g.config.openHushDoor) {
    return;
  }

  const stage = g.l.GetStage();
  const player = Isaac.GetPlayer();
  if (player === null) {
    return;
  }

  if (stage === 9) {
    const hushDoor = g.r.GetDoor(1);
    if (hushDoor !== null) {
      hushDoor.TryUnlock(player, true);
    }
    g.sfx.Stop(SoundEffect.SOUND_BOSS_LITE_ROAR);
  }
}
