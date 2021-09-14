import g from "../../../globals";
import { config } from "../../../modConfigMenu";

const MOM_AND_DAD_SOUND_EFFECTS = new Set([
  SoundEffect.SOUND_MOM_AND_DAD_1,
  SoundEffect.SOUND_MOM_AND_DAD_2,
  SoundEffect.SOUND_MOM_AND_DAD_3,
  SoundEffect.SOUND_MOM_AND_DAD_4,
]);

export function postNewLevel(): void {
  if (!config.silenceMomDad) {
    return;
  }

  for (const soundEffect of MOM_AND_DAD_SOUND_EFFECTS.values()) {
    g.sfx.Stop(soundEffect);
  }
}