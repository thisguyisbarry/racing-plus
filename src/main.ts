import { Keyboard } from "isaac-typescript-definitions";
import {
  log,
  setLogFunctionsGlobal,
  setTracebackFunctionsGlobal,
} from "isaacscript-common";
import * as entityTakeDmg from "./callbacks/entityTakeDmg";
import * as evaluateCache from "./callbacks/evaluateCache";
import * as executeCmd from "./callbacks/executeCmd";
import * as getPillEffect from "./callbacks/getPillEffect";
import * as inputAction from "./callbacks/inputAction";
import * as postBombInit from "./callbacks/postBombInit";
import * as postCurseEval from "./callbacks/postCurseEval";
import * as postEffectInit from "./callbacks/postEffectInit";
import * as postEffectUpdate from "./callbacks/postEffectUpdate";
import * as postEntityKill from "./callbacks/postEntityKill";
import * as postEntityRemove from "./callbacks/postEntityRemove";
import * as postFamiliarInit from "./callbacks/postFamiliarInit";
import * as postFamiliarRender from "./callbacks/postFamiliarRender";
import * as postFamiliarUpdate from "./callbacks/postFamiliarUpdate";
import * as postGameEnd from "./callbacks/postGameEnd";
import * as postLaserInit from "./callbacks/postLaserInit";
import * as postNPCInit from "./callbacks/postNPCInit";
import * as postNPCRender from "./callbacks/postNPCRender";
import * as postNPCUpdate from "./callbacks/postNPCUpdate";
import * as postPickupInit from "./callbacks/postPickupInit";
import * as postPickupRender from "./callbacks/postPickupRender";
import * as postPickupUpdate from "./callbacks/postPickupUpdate";
import * as postPlayerInit from "./callbacks/postPlayerInit";
import * as postPlayerRender from "./callbacks/postPlayerRender";
import * as postProjectileInit from "./callbacks/postProjectileInit";
import * as postRender from "./callbacks/postRender";
import * as postTearUpdate from "./callbacks/postTearUpdate";
import * as postUpdate from "./callbacks/postUpdate";
import * as useCard from "./callbacks/postUseCard";
import * as useItem from "./callbacks/postUseItem";
import * as usePill from "./callbacks/postUsePill";
import * as preEntitySpawn from "./callbacks/preEntitySpawn";
import * as preFamiliarCollision from "./callbacks/preFamiliarCollision";
import * as preGameExit from "./callbacks/preGameExit";
import * as preGetCollectible from "./callbacks/preGetCollectible";
import * as preNPCUpdate from "./callbacks/preNPCUpdate";
import * as preRoomEntitySpawn from "./callbacks/preRoomEntitySpawn";
import * as preSpawnClearAward from "./callbacks/preSpawnClearAward";
import * as preUseItem from "./callbacks/preUseItem";
import * as postAmbushStarted from "./callbacksCustom/postAmbushStarted";
import * as postBombExploded from "./callbacksCustom/postBombExploded";
import * as postBoneSwing from "./callbacksCustom/postBoneSwing";
import * as postCursedTeleport from "./callbacksCustom/postCursedTeleport";
import * as postCustomRevive from "./callbacksCustom/postCustomRevive";
import * as postFirstEsauJr from "./callbacksCustom/postFirstEsauJr";
import * as postFirstFlip from "./callbacksCustom/postFirstFlip";
import * as postFlip from "./callbacksCustom/postFlip";
import * as postGameStartedReordered from "./callbacksCustom/postGameStartedReordered";
import * as postGridEntityInit from "./callbacksCustom/postGridEntityInit";
import * as postGridEntityRemove from "./callbacksCustom/postGridEntityRemove";
import * as postGridEntityStateChanged from "./callbacksCustom/postGridEntityStateChanged";
import * as postGridEntityUpdate from "./callbacksCustom/postGridEntityUpdate";
import * as postItemPickup from "./callbacksCustom/postItemPickup";
import * as postNewLevelReordered from "./callbacksCustom/postNewLevelReordered";
import * as postNewRoomReordered from "./callbacksCustom/postNewRoomReordered";
import * as postNPCInitLate from "./callbacksCustom/postNPCInitLate";
import * as postPEffectUpdateReordered from "./callbacksCustom/postPEffectUpdateReordered";
import * as postPickupCollect from "./callbacksCustom/postPickupCollect";
import * as postPlayerChangeType from "./callbacksCustom/postPlayerChangeType";
import * as postPlayerInitLate from "./callbacksCustom/postPlayerInitLate";
import * as postPressurePlateUpdate from "./callbacksCustom/postPressurePlateUpdate";
import * as postPurchase from "./callbacksCustom/postPurchase";
import * as postRoomClearChanged from "./callbacksCustom/postRoomClearChanged";
import * as postSacrifice from "./callbacksCustom/postSacrifice";
import * as postSlotAnimationChanged from "./callbacksCustom/postSlotAnimationChanged";
import * as postTearInitVeryLate from "./callbacksCustom/postTearInitVeryLate";
import * as postTransformation from "./callbacksCustom/postTransformation";
import * as preCustomRevive from "./callbacksCustom/preCustomRevive";
import * as preItemPickup from "./callbacksCustom/preItemPickup";
import { MOD_NAME, VERSION } from "./constants";
import { hotkey1Function, hotkey2Function } from "./debugCode";
import { enableExtraConsoleCommandsRacingPlus } from "./features/mandatory/extraConsoleCommands";
import g from "./globals";
import { initFeatureVariables } from "./initFeatureVariables";
import { initMinimapAPI } from "./minimapAPI";
import { mod } from "./mod";

main();

function main() {
  welcomeBanner();
  initFeatureVariables();
  initMinimapAPI();

  enableExtraConsoleCommandsRacingPlus();

  registerCallbacksVanilla();
  registerCallbacksCustom();

  if (g.debug) {
    log("Racing+ debug mode enabled.");
    mod.saveDataManagerSetGlobal();
    setLogFunctionsGlobal();
    setTracebackFunctionsGlobal();

    // F1 shows the version of Racing+.
    mod.setHotkey(Keyboard.F2, hotkey1Function);
    mod.setHotkey(Keyboard.F3, hotkey2Function);
  }
}

function welcomeBanner() {
  const welcomeText = `${MOD_NAME} ${VERSION} initialized.`;
  const hyphens = "-".repeat(welcomeText.length);
  const welcomeTextBorder = `+-${hyphens}-+`;
  log(welcomeTextBorder);
  log(`| ${welcomeText} |`);
  log(welcomeTextBorder);
}

function registerCallbacksVanilla() {
  postNPCUpdate.init(); // 0
  postUpdate.init(); // 1
  postRender.init(); // 2
  useItem.init(); // 3
  useCard.init(); // 5
  postFamiliarUpdate.init(); // 6
  postFamiliarInit.init(); // 7
  evaluateCache.init(); // 8
  postPlayerInit.init(); // 9
  usePill.init(); // 10
  entityTakeDmg.init(); // 11
  postCurseEval.init(); // 12
  inputAction.init(); // 13
  postGameEnd.init(); // 16
  preGameExit.init(); // 17
  executeCmd.init(); // 22
  preUseItem.init(); // 23
  preEntitySpawn.init(); // 24
  postFamiliarRender.init(); // 25
  preFamiliarCollision.init(); // 26
  postNPCInit.init(); // 27
  postNPCRender.init(); // 28
  postPlayerRender.init(); // 32
  postPickupInit.init(); // 34
  postPickupUpdate.init(); // 35
  postPickupRender.init(); // 36
  postTearUpdate.init(); // 40
  postProjectileInit.init(); // 43
  postLaserInit.init(); // 47
  postEffectInit.init(); // 54
  postEffectUpdate.init(); // 55
  postBombInit.init(); // 57
  preGetCollectible.init(); // 62
  getPillEffect.init(); // 65
  postEntityRemove.init(); // 67
  postEntityKill.init(); // 68
  preNPCUpdate.init(); // 69
  preSpawnClearAward.init(); // 70
  preRoomEntitySpawn.init(); // 71
}

function registerCallbacksCustom() {
  postAmbushStarted.init();
  postBombExploded.init();
  postBoneSwing.init();
  postCursedTeleport.init();
  postCustomRevive.init();
  postFirstEsauJr.init();
  postFirstFlip.init();
  postFlip.init();
  postGameStartedReordered.init();
  postGridEntityInit.init();
  postGridEntityRemove.init();
  postGridEntityStateChanged.init();
  postGridEntityUpdate.init();
  postItemPickup.init();
  postNewLevelReordered.init();
  postNewRoomReordered.init();
  postNPCInitLate.init();
  postPEffectUpdateReordered.init();
  postPickupCollect.init();
  postPlayerChangeType.init();
  postPlayerInitLate.init();
  postPressurePlateUpdate.init();
  postPurchase.init();
  postRoomClearChanged.init();
  postSacrifice.init();
  postSlotAnimationChanged.init();
  postTearInitVeryLate.init();
  postTransformation.init();
  preCustomRevive.init();
  preItemPickup.init();
}
