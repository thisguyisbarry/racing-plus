import {
  getPlayerIndex,
  PlayerIndex,
  saveDataManager,
} from "isaacscript-common";
import g from "../../globals";
import { config } from "../../modConfigMenu";
import {
  CollectibleTypeCustom,
  FamiliarVariantCustom,
} from "../../types/enums";

const OFFSET = Vector(0, -16);
const DISTANCE_AWAY_FROM_PLAYER = 35;
// This exactly matches the speed of Sacrificial Dagger in Afterbirth+
// The value in Afterbirth+ is around 4.05
const SPEED_MULTIPLIER = 2.7;
const ROTATION_SPEED = 12;

const v = {
  run: {
    sawblades: new LuaTable<PlayerIndex, int>(),
  },
};

export function init(): void {
  saveDataManager("sawblade", v);
}

// ModCallbacks.MC_FAMILIAR_UPDATE (6)
// FamiliarVariantCustom.SAWBLADE
export function postFamiliarUpdateSawblade(familiar: EntityFamiliar): void {
  setPosition(familiar);
}

// It should rotate around the player like a Cube of Meat or Sacrificial Dagger does
function setPosition(familiar: EntityFamiliar) {
  familiar.Position = getPosition(familiar);

  // Sometimes, when the familiar collides with things, it can pick up some velocity,
  // which will cause the sprite to glitch out
  // Zero out the velocity on every frame
  familiar.Velocity = Vector.Zero;
}

function getPosition(familiar: EntityFamiliar) {
  const player = familiar.Parent;
  if (player === null) {
    error("A sawblade was spawned without a parent.");
  }
  const baseVector = Vector(0, DISTANCE_AWAY_FROM_PLAYER);
  const rotatedVector = baseVector.Rotated(
    familiar.FrameCount * SPEED_MULTIPLIER * -1,
  );
  return player.Position.add(rotatedVector);
}

// ModCallbacks.MC_POST_PLAYER_INIT (9)
export function postPlayerInit(player: EntityPlayer): void {
  const playerIndex = getPlayerIndex(player);
  v.run.sawblades.set(playerIndex, 0);
}

// ModCallbacks.MC_POST_GAME_STARTED (15)
export function postGameStarted(): void {
  if (!config.sawblade) {
    g.itemPool.RemoveCollectible(CollectibleTypeCustom.COLLECTIBLE_SAWBLADE);
  }
}

// ModCallbacks.MC_POST_FAMILIAR_RENDER (25)
// FamiliarVariantCustom.SAWBLADE
export function postFamiliarRenderSawblade(familiar: EntityFamiliar): void {
  rotateSprite(familiar);
}

function rotateSprite(familiar: EntityFamiliar) {
  const sprite = familiar.GetSprite();
  sprite.Rotation += ROTATION_SPEED;
}

// ModCallbacks.MC_PRE_FAMILIAR_COLLISION (26)
// FamiliarVariantCustom.SAWBLADE
export function preFamiliarCollisionSawblade(collider: Entity): void {
  // Make the familiar block shots like a Cube of Meat or Sacrificial Dagger
  if (collider.Type === EntityType.ENTITY_PROJECTILE) {
    collider.Die();
  }
}

// ModCallbacks.MC_POST_PLAYER_UPDATE (31)
export function postPlayerUpdate(player: EntityPlayer): void {
  const numSawblades = player.GetCollectibleNum(
    CollectibleTypeCustom.COLLECTIBLE_SAWBLADE,
  );

  const playerIndex = getPlayerIndex(player);
  const numOldSawblades = v.run.sawblades.get(playerIndex);
  if (numOldSawblades === undefined) {
    error(`Failed to get the number of sawblades for player: ${playerIndex}`);
  }

  if (numSawblades > numOldSawblades) {
    spawnNewSawblade(player);
    v.run.sawblades.set(playerIndex, numOldSawblades + 1);
  } else if (numSawblades < numOldSawblades) {
    removeSawblade(player);
    v.run.sawblades.set(playerIndex, numOldSawblades - 1);
  }
}

function spawnNewSawblade(player: EntityPlayer) {
  const sawblade = Isaac.Spawn(
    EntityType.ENTITY_FAMILIAR,
    FamiliarVariantCustom.SAWBLADE,
    0,
    Vector.Zero,
    Vector.Zero,
    player,
  );
  sawblade.Parent = player;

  // Initialize the sprite offset
  // (we must set the sprite offset via code since we are rotating the sprite on every frame)
  const sprite = sawblade.GetSprite();
  sprite.Offset = OFFSET;
}

function removeSawblade(player: EntityPlayer) {
  const sawblades = Isaac.FindByType(
    EntityType.ENTITY_FAMILIAR,
    FamiliarVariantCustom.SAWBLADE,
  );
  for (const sawblade of sawblades) {
    if (sawblade.Parent === null) {
      continue;
    }

    const playerHash = GetPtrHash(player);
    const parentHash = GetPtrHash(sawblade.Parent);
    if (playerHash === parentHash) {
      sawblade.Remove();
      return;
    }
  }
}
