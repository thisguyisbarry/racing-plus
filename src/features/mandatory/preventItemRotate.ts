import { getItemName, log, saveDataManager } from "isaacscript-common";
import g from "../../globals";

const ITEM_SPRITESHEET_ID = 1;

const v = {
  room: {
    /** Index is the InitSeed of the collectible. */
    trackedItems: new LuaTable<int, CollectibleType>(),
  },
};

export function init(): void {
  saveDataManager("preventItemRotate", v);
}

// Keep specific items from being affected by the Glitched Crown, Binge Eater,
// and the Tainted Isaac switching mechanic
export function postUpdate(): void {
  const collectibles = Isaac.FindByType(
    EntityType.ENTITY_PICKUP,
    PickupVariant.PICKUP_COLLECTIBLE,
  );
  for (const collectible of collectibles) {
    const trackedCollectibleType = v.room.trackedItems.get(
      collectible.InitSeed,
    );
    if (
      trackedCollectibleType !== undefined &&
      collectible.SubType !== trackedCollectibleType
    ) {
      // This item has switched, so restore it back to the way it was
      const oldSubType = collectible.SubType;
      collectible.SubType = trackedCollectibleType;

      // Changing the subtype will not affect the existing sprite
      const sprite = collectible.GetSprite();
      const itemConfigItem = g.itemConfig.GetCollectible(
        trackedCollectibleType,
      );
      if (itemConfigItem === null) {
        error(`Failed to get the item config for: ${trackedCollectibleType}`);
      }
      const gfxFileName = itemConfigItem.GfxFileName;
      sprite.ReplaceSpritesheet(ITEM_SPRITESHEET_ID, gfxFileName);
      sprite.LoadGraphics();

      log(
        `Prevented pedestal item ${getItemName(
          trackedCollectibleType,
        )} from rotating to item ${getItemName(oldSubType)}.`,
      );
    }
  }
}

export function checkQuestItem(
  collectibleType: CollectibleType,
  seed: int,
): void {
  const itemConfigItem = g.itemConfig.GetCollectible(collectibleType);
  if (itemConfigItem !== null) {
    const isQuestItem = itemConfigItem.HasTags(ItemConfigTag.QUEST);
    if (isQuestItem) {
      v.room.trackedItems.set(seed, collectibleType);
    }
  }
}