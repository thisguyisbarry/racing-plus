/*
export function main(): void {
  // Draw graphics
  sprites.display();
  schoolbag.spriteDisplay();
  soulJar.spriteDisplay();
  theLostHealth();
  holyMantle();
  leadPencilChargeBar();
  schoolbag.glowingHourGlass();
  timer.checkDisplayRaceSpeedrun();
  timer.checkDisplaySeededDeath();
  pills.postRender();
  changeCharOrder.postRender();
  changeKeybindings.postRender();
  drawVersion();

  // Check for inputs
  checkDirection();

  // Make Cursed Eye seeded
  checkCursedEye();

  // Check for trapdoor related things
  fastTravel.trapdoor.checkState();

  // Check to see if ( we are subverting a teleport from Gurdy, Mom, Mom's Heart, || It Lives
  checkSubvertTeleport();

  // Check for the seeded death mechanic
  // (this is not in the "PostRender.Race()" function because it also applies to speedruns)
  seededDeath.postRender();

  // Do race specific stuff
  shadow.Draw();

  // Handle things for multi-character speedruns
  speedrunPostRender.main();
}

function theLostHealth() {
  const character = g.p.GetPlayerType();
  if (character !== PlayerType.PLAYER_THELOST) {
    return;
  }

  if (g.run.lostHealthSprite === null) {
    g.run.lostHealthSprite = Sprite();
    g.run.lostHealthSprite.Load("gfx/ui/p20_lost_health.anm2", true);
  }

  const hudOffsetX = 0;
  const hudOffsetY = 0;

  let offsetX = hudOffsetX + 41;
  if (g.p.GetExtraLives() > 0) {
    offsetX += 24;
  }

  const offsetY = hudOffsetY + 2;

  let animationToPlay = "Empty_Heart";
  if (g.p.GetSoulHearts() >= 1) {
    animationToPlay = "Lost_Heart_Half";
  }
  g.run.lostHealthSprite.Play(animationToPlay, true);
  g.run.lostHealthSprite.Render(
    Vector(offsetX, offsetY),
    Vector.Zero,
    Vector.Zero,
  );
}

function holyMantle() {
  const effects = g.p.GetEffects();
  const numMantles = effects.GetCollectibleEffectNum(
    CollectibleType.COLLECTIBLE_HOLY_MANTLE,
  );
  if (numMantles < 1) {
    return;
  }

  if (g.run.holyMantleSprite === null) {
    g.run.holyMantleSprite = Sprite();
    g.run.holyMantleSprite.Load("gfx/ui/p20_holy_mantle.anm2", true);
  }

  const hudOffset1Heart = 41;
  const hudOffset2Heart = hudOffset1Heart + 12;
  const hudOffset3Heart = hudOffset2Heart + 12;
  const hudOffset4Heart = hudOffset3Heart + 12;
  const hudOffset5Heart = hudOffset4Heart + 12;
  const hudOffset6Heart = hudOffset5Heart + 12;

  const hudOffset1Row = 2;
  const hudOffset2Row = hudOffset1Row + 10;

  let yOffset: int;
  let xOffset = hudOffset6Heart;

  const visibleHearts = misc.getPlayerVisibleHearts();
  if (visibleHearts > 6) {
    yOffset = hudOffset2Row;
  } else {
    yOffset = hudOffset1Row;
  }

  let xHeart = visibleHearts % 6;
  if (xHeart === 0) {
    xHeart = 6;
  }

  if (xHeart <= 1) {
    xOffset = hudOffset1Heart;
  } else if (xHeart === 2) {
    xOffset = hudOffset2Heart;
  } else if (xHeart === 3) {
    xOffset = hudOffset3Heart;
  } else if (xHeart === 4) {
    xOffset = hudOffset4Heart;
  } else if (xHeart === 5) {
    xOffset = hudOffset5Heart;
  } else if (xHeart >= 6) {
    xOffset = hudOffset6Heart;
  }

  if (g.l.GetCurses() === LevelCurse.CURSE_OF_THE_UNKNOWN) {
    xOffset = hudOffset1Heart;
  }

  const character = g.p.GetPlayerType();
  if (character === PlayerType.PLAYER_THELOST) {
    if (g.p.GetExtraLives() > 0) {
      xOffset += 24;
    }
  }

  let animationToPlay;
  if (character === PlayerType.PLAYER_KEEPER) {
    animationToPlay = "Keeper_Mantle";
  } else {
    animationToPlay = "Mantle";
  }

  g.run.holyMantleSprite.Play(animationToPlay, true);
  g.run.holyMantleSprite.Render(
    Vector(xOffset, yOffset),
    Vector.Zero,
    Vector.Zero,
  );
}

// Make an additional charge bar for the Lead Pencil
function leadPencilChargeBar() {
  const character = g.p.GetPlayerType();
  const flyingOffset = g.p.GetFlyingOffset();

  if (
    !g.p.HasCollectible(CollectibleType.COLLECTIBLE_LEAD_PENCIL) ||
    character === PlayerType.PLAYER_AZAZEL || // 7
    character === PlayerType.PLAYER_LILITH || // 13
    character === PlayerType.PLAYER_THEFORGOTTEN || // 16
    g.p.HasCollectible(CollectibleType.COLLECTIBLE_DR_FETUS) || // 52
    g.p.HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) || // 68
    g.p.HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) || // 114
    g.p.HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) || // 118
    g.p.HasCollectible(CollectibleType.COLLECTIBLE_EPIC_FETUS) || // 168
    g.p.HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) // 395
  ) {
    return;
  }

  // Initialize the sprite
  if (g.run.pencilSprite === null) {
    g.run.pencilSprite = Sprite();
    g.run.pencilSprite.Load("gfx/chargebar_pencil.anm2", true);
  }

  // Adjust the position slightly so that it appears properly centered on the player,
  // taking into account the size of the player sprite and if there are any existing charge bars
  const adjustX = 18.5 * g.p.SpriteScale.X;
  let adjustY = 15 + 54 * g.p.SpriteScale.Y - flyingOffset.Y;
  const chargeBarHeight = 4.5;
  if (
    g.p.HasCollectible(CollectibleType.COLLECTIBLE_CHOCOLATE_MILK) || // 69
    g.p.HasCollectible(CollectibleType.COLLECTIBLE_MONSTROS_LUNG) || // 229
    g.p.HasCollectible(CollectibleType.COLLECTIBLE_CURSED_EYE) // 316
  ) {
    adjustY += chargeBarHeight;
    if (flyingOffset.Y !== 0) {
      // When the character has flying, the charge bar will overlap, so manually adjust for this
      adjustY -= 6; // 5 is too small and 6 is just right
    }
  }
  if (g.p.HasCollectible(CollectibleType.COLLECTIBLE_MAW_OF_VOID)) {
    adjustY += chargeBarHeight;
  }
  const adjustedPosition = Vector(
    g.p.Position.X + adjustX,
    g.p.Position.Y - adjustY,
  );

  // Render it
  // (there are 101 frames in the "Charging animation" and it takes 15 shots to fire a pencil
  // barrage)
  let barFrame = g.run.pencilCounter * (101 / 15);
  barFrame = Math.round(barFrame);
  g.run.pencilSprite.SetFrame("Charging", barFrame);
  g.run.pencilSprite.Render(
    g.r.WorldToScreenPosition(adjustedPosition),
    Vector.Zero,
    Vector.Zero,
  );
}

// Fix the bug where diagonal knife throws have a 1-frame window when playing on keyboard (1/2)
function checkDirection() {
  const directions: boolean[] = [];
  for (let i = 0; i < 4; i++) {
    // This corresponds to the "ButtonAction.ACTION_SHOOT" enum

    const directionPushed = Input.IsActionPressed(i + 3, 0);
    // (e.g. ButtonAction.ACTION_SHOOTLEFT is 4)
    directions.push(directionPushed);
  }
  g.run.directions.push(directions);
  if (g.run.directions.length > 2) {
    // We want there to be a 3-frame window instead of a 1-frame window
    g.run.directions.splice(0, 1);
  }
}

// Make Cursed Eye seeded
// (this has to be in the PostRender callback because game frames do not tick when the teleport
// animation is happening)
function checkCursedEye() {
  const gameFrameCount = g.g.GetFrameCount();
  const playerSprite = g.p.GetSprite();
  const hearts = g.p.GetHearts();
  const soulHearts = g.p.GetSoulHearts();

  if (
    !g.p.HasCollectible(CollectibleType.COLLECTIBLE_CURSED_EYE) ||
    !playerSprite.IsPlaying("TeleportUp") ||
    g.run.lastDamageFrame === 0 ||
    // If we were not damaged on this frame, we can assume it is not a Cursed Eye teleport
    gameFrameCount !== g.run.lastDamageFrame ||
    g.run.usedTeleport
  ) {
    return;
  }

  // Account for the Cursed Skull trinket
  if (
    g.p.HasTrinket(TrinketType.TRINKET_CURSED_SKULL) &&
    // 1/2 of a heart remaining
    ((hearts === 1 && soulHearts === 0) || (hearts === 0 && soulHearts === 1))
  ) {
    Isaac.DebugString("Cursed Skull teleport detected.");
    return;
  }

  Isaac.DebugString("Cursed Eye teleport detected.");
  useItem.teleport();
}

// Check to see if we are subverting a teleport from Gurdy, Mom, Mom's Heart, or It Lives
function checkSubvertTeleport() {
  const stage = g.l.GetStage();

  if (!g.run.room.teleportSubverted) {
    return;
  }
  g.run.room.teleportSubverted = false;

  // Find the correct position to teleport to, depending on which door we entered from
  let pos: Vector;
  if (stage === 6) {
    pos = getEnterPosForMom();
  } else {
    pos = getEnterPosForGurdyOrItLives();
  }

  // Teleport them and make them visible again
  g.p.Position = pos;
  g.p.SpriteScale = g.run.room.teleportSubvertScale;

  // Also, teleport all of the familiars (and make them visible again)
  const familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR);
  for (const familiar of familiars) {
    familiar.Position = pos;
    familiar.Visible = true;
  }

  Isaac.DebugString("Subverted a position teleport (2/2).");
}

function drawVersion() {
  const gameFrameCount = g.g.GetFrameCount();

  // Make the version persist for at least 2 seconds after the player presses "v"
  if (Input.IsButtonPressed(Keyboard.KEY_V, 0)) {
    g.run.showVersionFrame = gameFrameCount + 60;
  }

  if (g.run.showVersionFrame === 0 || gameFrameCount > g.run.showVersionFrame) {
    return;
  }

  const center = misc.getScreenCenterPosition();
  let text: string;
  let x: int;
  let y: int;

  // Render the version of the mod
  text = "Racing+";
  x = center.X - 3 * text.length;
  y = center.Y + 40;
  Isaac.RenderText(text, x, y, 2, 2, 2, 2);

  text = VERSION;
  x = center.X - 3 * text.length;
  y += 15;
  Isaac.RenderText(text, x, y, 2, 2, 2, 2);

  if (RacingPlusRebalancedVersion !== undefined) {
    text = "Racing+ Rebalanced";
    x = center.X - 3 * text.length;
    y += 15;
    Isaac.RenderText(text, x, y, 2, 2, 2, 2);

    text = RacingPlusRebalancedVersion.toString();
    x = center.X - 3 * text.length;
    y += 15;
    Isaac.RenderText(text, x, y, 2, 2, 2, 2);
  }
}
*/
