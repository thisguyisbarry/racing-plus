import {
  countEntities,
  getPlayers,
  nextSeed,
  repeat,
  saveDataManager,
} from "isaacscript-common";
import g from "../../globals";
import { RaceStatus } from "../race/types/RaceStatus";
import { speedrunIsFinished } from "../speedrun/exported";

const v = {
  run: {
    numFireworksSpawned: 0,
    seed: 0 as Seed,
  },
};

export function init(): void {
  saveDataManager("fireworks", v);
}

// ModCallbacks.MC_POST_UPDATE (1)
export function postUpdate(): void {
  makeFireworksQuieter();

  if (
    (g.raceVars.finished &&
      g.race.status === RaceStatus.IN_PROGRESS &&
      g.race.place === 1 &&
      g.race.numEntrants >= 3) ||
    speedrunIsFinished()
  ) {
    spawnSparkleOnPlayer();
    spawnFireworks();
  }
}

function makeFireworksQuieter() {
  if (!g.sfx.IsPlaying(SoundEffect.SOUND_BOSS1_EXPLOSIONS)) {
    return;
  }

  const numFireworks = countEntities(
    EntityType.ENTITY_EFFECT,
    EffectVariant.FIREWORKS,
  );
  if (numFireworks > 0) {
    g.sfx.AdjustVolume(SoundEffect.SOUND_BOSS1_EXPLOSIONS, 0.2);
  }
}

function spawnSparkleOnPlayer() {
  for (const player of getPlayers()) {
    const randomVector = RandomVector().mul(10);
    const blingPosition = player.Position.add(randomVector);
    Isaac.Spawn(
      EntityType.ENTITY_EFFECT,
      EffectVariant.ULTRA_GREED_BLING,
      0,
      blingPosition,
      Vector.Zero,
      undefined,
    );
  }
}

function spawnFireworks() {
  const gameFrameCount = g.g.GetFrameCount();

  // Spawn 30 fireworks (1000.104.0)
  // (some can be duds randomly)
  if (v.run.numFireworksSpawned < 40 && gameFrameCount % 20 === 0) {
    repeat(5, () => {
      v.run.numFireworksSpawned += 1;
      v.run.seed = nextSeed(v.run.seed);
      const randomGridIndex = g.r.GetRandomTileIndex(v.run.seed);
      const position = g.r.GetGridPosition(randomGridIndex);
      const firework = Isaac.Spawn(
        EntityType.ENTITY_EFFECT,
        EffectVariant.FIREWORKS,
        0,
        position,
        Vector.Zero,
        undefined,
      ).ToEffect();
      if (firework !== undefined) {
        firework.SetTimeout(20);
      }
    });
  }
}

// ModCallbacks.MC_POST_GAME_STARTED (15)
export function postGameStarted(): void {
  v.run.seed = g.seeds.GetStartSeed();
}
