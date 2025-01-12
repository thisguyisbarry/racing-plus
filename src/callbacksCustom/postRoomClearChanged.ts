import { ModCallbackCustom } from "isaacscript-common";
import * as solCustom from "../features/items/solCustom";
import { fastClearPostRoomClearChanged } from "../features/optional/major/fastClear/callbacks/postRoomClearChanged";
import { speedrunPostRoomClearChanged } from "../features/speedrun/callbacks/postRoomClearChanged";
import { mod } from "../mod";

export function init(): void {
  mod.AddCallbackCustom(ModCallbackCustom.POST_ROOM_CLEAR_CHANGED, main);
}

function main(roomClear: boolean) {
  fastClearPostRoomClearChanged(roomClear);
  speedrunPostRoomClearChanged(roomClear);
  solCustom.postRoomClearChanged(roomClear);
}
