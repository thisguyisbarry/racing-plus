import { EntityType, ModCallback } from "isaac-typescript-definitions";
import * as hushCollisionFix from "../features/mandatory/hushCollisionFix";
import * as fastBigHorn from "../features/optional/bosses/fastBigHorn";
import * as fastHaunt from "../features/optional/bosses/fastHaunt";
import * as fastPin from "../features/optional/bosses/fastPin";
import * as preventDeathSlow from "../features/optional/bosses/preventDeathSlow";
import * as removeLambBody from "../features/optional/bosses/removeLambBody";
import * as appearHands from "../features/optional/enemies/appearHands";
import * as disableInvulnerability from "../features/optional/enemies/disableInvulnerability";
import * as fastDusts from "../features/optional/enemies/fastDusts";
import * as fastGhosts from "../features/optional/enemies/fastGhosts";
import * as fastHands from "../features/optional/enemies/fastHands";
import * as fastNeedles from "../features/optional/enemies/fastNeedles";
import * as globinSoftlock from "../features/optional/enemies/globinSoftlock";
import * as fastClearPostNPCUpdate from "../features/optional/major/fastClear/callbacks/postNPCUpdate";
import { racePostNPCUpdateDarkEsau } from "../features/race/callbacks/postNPCUpdate";
import { mod } from "../mod";

export function init(): void {
  mod.AddCallback(ModCallback.POST_NPC_UPDATE, main);

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    globin,
    EntityType.GLOBIN, // 24
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    pin,
    EntityType.PIN, // 62
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    death,
    EntityType.DEATH, // 66
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    momsHand,
    EntityType.MOMS_HAND, // 213
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    wizoob,
    EntityType.WIZOOB, // 219
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    ragling,
    EntityType.RAGLING, // 246
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    haunt,
    EntityType.THE_HAUNT, // 260
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    dingle,
    EntityType.DINGLE, // 261
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    lamb,
    EntityType.THE_LAMB, // 273
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    redGhost,
    EntityType.RED_GHOST, // 285
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    momsDeadHand,
    EntityType.MOMS_DEAD_HAND, // 287
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    stoney,
    EntityType.STONEY, // 302
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    hush,
    EntityType.HUSH, // 407
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    bigHorn,
    EntityType.BIG_HORN, // 411
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    darkEsau,
    EntityType.DARK_ESAU, // 866
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    needle,
    EntityType.NEEDLE, // 881
  );

  mod.AddCallback(
    ModCallback.POST_NPC_UPDATE,
    dust,
    EntityType.DUST, // 882
  );
}

function main(npc: EntityNPC) {
  fastClearPostNPCUpdate.main(npc);
}

// EntityType.GLOBIN (24)
function globin(npc: EntityNPC) {
  globinSoftlock.postNPCUpdateGlobin(npc);
}

// EntityType.PIN (62)
function pin(npc: EntityNPC) {
  fastPin.postNPCUpdatePin(npc);
}

// EntityType.DEATH (66)
function death(npc: EntityNPC) {
  preventDeathSlow.postNPCUpdateDeath(npc);
}

// EntityType.MOMS_HAND (213)
function momsHand(npc: EntityNPC) {
  appearHands.postNPCUpdateMomsHand(npc);
  fastHands.postNPCUpdateMomsHand(npc);
}

// EntityType.WIZOOB (219)
function wizoob(npc: EntityNPC) {
  disableInvulnerability.postNPCUpdateWizoob(npc);
  fastGhosts.postNPCUpdateWizoob(npc);
}

// EntityType.RAGLING (246)
function ragling(npc: EntityNPC) {
  fastClearPostNPCUpdate.ragling(npc);
}

// EntityType.THE_HAUNT (260)
function haunt(npc: EntityNPC) {
  disableInvulnerability.postNPCUpdateHaunt(npc);
  fastHaunt.postNPCUpdateHaunt(npc);
}

// EntityType.DINGLE (261)
function dingle(npc: EntityNPC) {
  fastClearPostNPCUpdate.dingle(npc);
}

// EntityType.THE_LAMB (273)
function lamb(npc: EntityNPC) {
  removeLambBody.postNPCUpdateLamb(npc);
}

// EntityType.RED_GHOST (285)
function redGhost(npc: EntityNPC) {
  disableInvulnerability.postNPCUpdateRedGhost(npc);
  fastGhosts.postNPCUpdateRedGhost(npc);
}

// EntityType.MOMS_DEAD_HAND (287)
function momsDeadHand(npc: EntityNPC) {
  appearHands.postNPCUpdateMomsDeadHand(npc);
  fastHands.postNPCUpdateMomsDeadHand(npc);
}

// EntityType.STONEY (302)
function stoney(npc: EntityNPC) {
  fastClearPostNPCUpdate.stoney(npc);
}

// EntityType.HUSH (407)
function hush(npc: EntityNPC) {
  hushCollisionFix.postNPCUpdateHush(npc);
}

// EntityType.BIG_HORN (411)
function bigHorn(npc: EntityNPC) {
  fastBigHorn.postNPCUpdateBigHorn(npc);
}

// EntityType.DARK_ESAU (866)
function darkEsau(npc: EntityNPC) {
  racePostNPCUpdateDarkEsau(npc);
}

// EntityType.NEEDLE (881)
function needle(npc: EntityNPC) {
  fastNeedles.postNPCUpdateNeedle(npc);
}

// EntityType.DUST (882)
function dust(npc: EntityNPC) {
  fastDusts.postNPCUpdateDust(npc);
}
