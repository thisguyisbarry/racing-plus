import g from "../globals";
import { CollectibleTypeCustom } from "../types/enums";

const functionMap = new Map<CacheFlag, (player: EntityPlayer) => void>();
export default functionMap;

// 1 << 4
functionMap.set(CacheFlag.CACHE_SPEED, (player: EntityPlayer) => {
  debugSpeed(player);
});

function debugSpeed(player: EntityPlayer) {
  if (g.run.debugSpeed) {
    player.MoveSpeed = 2;
  }
}

// 1 << 10
functionMap.set(CacheFlag.CACHE_LUCK, (player: EntityPlayer) => {
  thirteenLuck(player);
  fifteenLuck(player);
});

function thirteenLuck(player: EntityPlayer) {
  const num13Luck = player.GetCollectibleNum(
    CollectibleTypeCustom.COLLECTIBLE_13_LUCK,
  );
  for (let i = 0; i < num13Luck; i++) {
    player.Luck += 13;
  }
}

function fifteenLuck(player: EntityPlayer) {
  const num15Luck = player.GetCollectibleNum(
    CollectibleTypeCustom.COLLECTIBLE_15_LUCK,
  );
  for (let i = 0; i < num15Luck; i++) {
    player.Luck += 15;
  }
}
