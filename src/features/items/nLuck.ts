// This is the logic for the custom items "13 Luck" and "15 Luck".

// We deliberately do not account for a player having multiple copies of these items because it
// should be impossible and it makes the code more complicated.

import { PlayerType } from "isaac-typescript-definitions";
import {
  isEden,
  mapGetPlayer,
  mapSetPlayer,
  PlayerIndex,
} from "isaacscript-common";
import { CollectibleTypeCustom } from "../../enums/CollectibleTypeCustom";
import { mod } from "../../mod";

const v = {
  run: {
    edenBaseLuckMap: new Map<PlayerIndex, float>(),
  },
};

export function init(): void {
  mod.saveDataManager("nLuck", v);
}

// ModCallback.EVALUATE_CACHE (8)
// CacheFlag.LUCK (1 << 10)
export function evaluateCacheLuck(player: EntityPlayer): void {
  const has13Luck = player.HasCollectible(CollectibleTypeCustom.THIRTEEN_LUCK);
  const has15Luck = player.HasCollectible(CollectibleTypeCustom.FIFTEEN_LUCK);

  if (!has13Luck && !has15Luck) {
    return;
  }

  const targetLuck = has15Luck ? 15 : 13;
  const luckModifier = getCharacterLuckModifier(player);
  const totalLuck = targetLuck + luckModifier;
  player.Luck += totalLuck;
}

/**
 * Some characters start with negative luck. We give those players extra luck to compensate,
 * depending on the amount of negative luck that they start with.
 */
function getCharacterLuckModifier(player: EntityPlayer) {
  const character = player.GetPlayerType();
  switch (character) {
    // 8
    case PlayerType.LAZARUS: {
      return 1;
    }

    // 9, 30
    case PlayerType.EDEN:
    case PlayerType.EDEN_B: {
      const baseLuck = mapGetPlayer(v.run.edenBaseLuckMap, player);
      return baseLuck === undefined ? 0 : baseLuck * -1;
    }

    // 14
    case PlayerType.KEEPER: {
      return 2;
    }

    // 20
    case PlayerType.ESAU: {
      return 1;
    }

    // 33
    case PlayerType.KEEPER_B: {
      return 2;
    }

    // 38
    case PlayerType.LAZARUS_2_B: {
      return 2;
    }

    default: {
      return 0;
    }
  }
}

// ModCallback.POST_PLAYER_INIT (9)
export function postPlayerInit(player: EntityPlayer): void {
  if (!isEden(player)) {
    return;
  }

  mapSetPlayer(v.run.edenBaseLuckMap, player, player.Luck);
}
