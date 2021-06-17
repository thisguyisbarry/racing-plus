import * as fadeBosses from "../features/optional/bosses/fadeBosses";
import * as fastClearPostEntityKill from "../features/optional/major/fastClear/callbacks/postEntityKill";

export function main(entity: Entity): void {
  fastClearPostEntityKill.main(entity);
  fadeBosses.postEntityKill(entity);
}
