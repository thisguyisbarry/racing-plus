export const BANNED_COLLECTIBLES = new Set<CollectibleType>([
  CollectibleType.COLLECTIBLE_MERCURIUS,
  CollectibleType.COLLECTIBLE_TMTRAINER,
]);

export const BANNED_COLLECTIBLES_ON_SEEDED_RACES = new Set<CollectibleType>([
  // Since drops are seeded and given in order, Glyph of Balance does not work properly
  CollectibleType.COLLECTIBLE_GLYPH_OF_BALANCE, // 464

  // Damocles is unseeded
  CollectibleType.COLLECTIBLE_DAMOCLES, // 577
  CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE, // 656

  // Sol is mostly useless if you start with the Compass
  CollectibleType.COLLECTIBLE_SOL, // 588
]);

export const BANNED_COLLECTIBLES_WITH_VOID = new Set<CollectibleType>([
  CollectibleType.COLLECTIBLE_MEGA_BLAST,
  CollectibleType.COLLECTIBLE_MEGA_MUSH,
]);

export const BANNED_TRINKETS = new Set<TrinketType>([
  TrinketType.TRINKET_KARMA, // Since all Donation Machines are removed, it has no purpose
]);

export const BANNED_TRINKETS_ON_SEEDED_RACES = new Set<TrinketType>([
  // Cain's Eye is useless if you start with the Compass
  TrinketType.TRINKET_CAINS_EYE, // 59

  // Remove certain trinkets that mess up floor generation
  TrinketType.TRINKET_SILVER_DOLLAR, // 110
  TrinketType.TRINKET_BLOODY_CROWN, // 111
  TrinketType.TRINKET_TELESCOPE_LENS, // 152
  TrinketType.TRINKET_HOLY_CROWN, // 155
  TrinketType.TRINKET_WICKED_CROWN, // 161
]);
