// cspell:disable
const CARD_MAP = new Map([
  ["fool", 1],
  ["magician", 2],
  ["magi", 2],
  ["mag", 2],
  ["high priestess", 3],
  ["highpriestess", 3],
  ["high", 3],
  ["priestess", 3],
  ["priest", 3],
  ["hp", 3],
  ["empress", 4],
  ["emperor", 5],
  ["emp", 5],
  ["hierophant", 6],
  ["hiero", 6],
  ["lovers", 7],
  ["chariot", 8],
  ["justice", 9],
  ["hermit", 10],
  ["wheel of fortune", 11],
  ["wheeloffortune", 11],
  ["wheel", 11],
  ["fortune", 11],
  ["strength", 12],
  ["str", 12],
  ["hanged man", 13],
  ["hangedman", 13],
  ["hanged", 13],
  ["death", 14],
  ["temperance", 15],
  ["devil", 16],
  ["tower", 17],
  ["stars", 18],
  ["moon", 19],
  ["sun", 20],
  ["judgement", 21],
  ["judge", 21],
  ["world", 22],
  ["2 of clubs", 23],
  ["2ofclubs", 23],
  ["2clubs", 23],
  ["2 of diamonds", 24],
  ["2ofdiamonds", 24],
  ["2diamonds", 24],
  ["2 of spades", 25],
  ["2ofspades", 25],
  ["2spades", 25],
  ["2 of hearts", 26],
  ["2ofhearts", 26],
  ["2hearts", 26],
  ["ace of clubs", 27],
  ["aceofclubs", 27],
  ["aceclubs", 27],
  ["ace of diamonds", 28],
  ["aceofdiamonds", 28],
  ["acediamonds", 28],
  ["ace of spades", 29],
  ["aceofspades", 29],
  ["acespades", 29],
  ["ace of hearts", 30],
  ["aceofhearts", 30],
  ["acehearts", 30],
  ["joker", 31],
  ["hagalaz", 32],
  ["destruction", 32],
  ["jera", 33],
  ["abundance", 33],
  ["ehwaz", 34],
  ["passage", 34],
  ["dagaz", 35],
  ["purity", 35],
  ["ansuz", 36],
  ["vision", 36],
  ["perthro", 37],
  ["change", 37],
  ["berkano", 38],
  ["companionship", 38],
  ["algiz", 39],
  ["resistance", 39],
  ["shield", 39],
  ["blank", 40],
  ["black", 41],
  ["chaos", 42],
  ["credit", 43],
  ["rules", 44],
  ["against humanity", 45],
  ["againsthumanity", 45],
  ["humanity", 45],
  ["suicide king", 46],
  ["suicideking", 46],
  ["suicide", 46],
  ["get out of jail free", 47],
  ["getoutofjailfree", 47],
  ["get out of jail", 47],
  ["getoutofjail", 47],
  ["get out", 47],
  ["getout", 47],
  ["jail", 47],
  ["?", 48],
  ["dice shard", 49],
  ["diceshard", 49],
  ["dice", 49],
  ["shard", 49],
  ["emergency contact", 50],
  ["emergencycontact", 50],
  ["emergency", 50],
  ["contact", 50],
  ["holy", 51],
  ["huge growth", 52],
  ["hugegrowth", 52],
  ["growth", 52],
  ["ancient recall", 53],
  ["ancientrecall", 53],
  ["ancient", 53],
  ["recall", 53],
  ["era walk", 54],
  ["erawalk", 54],
  ["era", 54],
  ["walk", 54],
  ["rune shard", 55],
  ["runeshard", 55],
  ["shard", 55],
  ["fool?", 56],
  ["fool2", 56],
  ["magician?", 57],
  ["magician2", 57],
  ["magi?", 57],
  ["magi2", 57],
  ["mag?", 57],
  ["mag2", 57],
  ["high priestess?", 58],
  ["high priestess2", 58],
  ["highpriestess?", 58],
  ["highpriestess2", 58],
  ["high?", 58],
  ["high2", 58],
  ["priestess?", 58],
  ["priestess2", 58],
  ["priest?", 58],
  ["priest2", 58],
  ["hp?", 58],
  ["hp2", 58],
  ["empress?", 59],
  ["empress2", 59],
  ["emperor?", 60],
  ["emperor2", 60],
  ["emp?", 60],
  ["emp2", 60],
  ["hierophant?", 61],
  ["hierophant2", 61],
  ["hiero?", 61],
  ["hiero2", 61],
  ["lovers?", 62],
  ["lovers2", 62],
  ["chariot?", 63],
  ["chariot2", 63],
  ["justice?", 64],
  ["justice2", 64],
  ["hermit?", 65],
  ["hermit2", 65],
  ["wheel of fortune?", 66],
  ["wheel of fortune2", 66],
  ["wheeloffortune?", 66],
  ["wheeloffortune2", 66],
  ["wheel?", 66],
  ["wheel2", 66],
  ["fortune?", 66],
  ["fortune2", 66],
  ["strength?", 67],
  ["strength2", 67],
  ["str?", 67],
  ["str2", 67],
  ["hanged man?", 68],
  ["hanged man2", 68],
  ["hangedman?", 68],
  ["hangedman2", 68],
  ["hanged?", 68],
  ["hanged2", 68],
  ["death?", 69],
  ["death2", 69],
  ["temperance?", 70],
  ["temperance2", 70],
  ["devil?", 71],
  ["devil2", 71],
  ["tower?", 72],
  ["tower2", 72],
  ["stars?", 73],
  ["stars2", 73],
  ["moon?", 74],
  ["moon2", 74],
  ["sun?", 75],
  ["sun2", 75],
  ["judgement?", 76],
  ["judgement2", 76],
  ["judge?", 76],
  ["judge2", 76],
  ["world?", 77],
  ["world2", 77],
  ["cracked key", 78],
  ["crackedkey", 78],
  ["cracked", 78],
  ["key", 78],
  ["queen of hearts", 79],
  ["queenofhearts", 79],
  ["queen hearts", 79],
  ["queenhearts", 79],
  ["queen", 79],
  ["wild card", 80],
  ["wildcard", 80],
  ["wild", 80],
  ["soul of isaac", 81],
  ["soulofisaac", 81],
  ["soulisaac", 81],
  ["isaac", 81],
  ["soul of magdalene", 82],
  ["soulofmagdalene", 82],
  ["soulmagdalene", 82],
  ["magdalene", 82],
  ["soul of cain", 83],
  ["soulofcain", 83],
  ["soulcain", 83],
  ["cain", 83],
  ["soul of judas", 84],
  ["soulofjudas", 84],
  ["souljudas", 84],
  ["judas", 84],
  ["soul of ???", 85],
  ["soulof???", 85],
  ["soul???", 85],
  ["???", 85],
  ["soul of blue baby", 85],
  ["soulofbluebaby", 85],
  ["soulbluebaby", 85],
  ["blue baby", 85],
  ["bluebaby", 85],
  ["soul of eve", 86],
  ["soulofeve", 86],
  ["souleve", 86],
  ["eve", 86],
  ["soul of samson", 87],
  ["soulofsamson", 87],
  ["soulsamson", 87],
  ["samson", 87],
  ["soul of azazel", 88],
  ["soulofazazel", 88],
  ["soulazazel", 88],
  ["azazel", 88],
  ["soul of lazarus", 89],
  ["souloflazarus", 89],
  ["soullazarus", 89],
  ["lazarus", 89],
  ["soul of eden", 90],
  ["soulofeden", 90],
  ["souleden", 90],
  ["eden", 90],
  ["soul of the lost", 91],
  ["soulofthelost", 91],
  ["souloflost", 91],
  ["soullost", 91],
  ["the lost", 91],
  ["thelost", 91],
  ["lost", 91],
  ["soul of lilith", 92],
  ["souloflilith", 92],
  ["soullilith", 92],
  ["lilith", 92],
  ["soul of the keeper", 93],
  ["soulofthekeeper", 93],
  ["soulofkeeper", 93],
  ["soulkeeper", 93],
  ["keeper", 93],
  ["soul of apollyon", 94],
  ["soulofapollyon", 94],
  ["soulapollyon", 94],
  ["apollyon", 94],
  ["soul of the forgotten", 95],
  ["souloftheforgotten", 95],
  ["soulofforgotten", 95],
  ["soulforgotten", 95],
  ["forgotten", 95],
  ["soul of bethany", 96],
  ["soulofbethany", 96],
  ["soulbethany", 96],
  ["bethany", 96],
  ["soul of jacob and esau", 97],
  ["soul of jacob & esau", 97],
  ["soul of jacob", 97],
  ["soulofjacobandesau", 97],
  ["soulofjacob&esau", 97],
  ["soulofjacob", 97],
  ["souljacobandesau", 97],
  ["souljacob&esau", 97],
  ["souljacob", 97],
  ["jacobandesau", 97],
  ["jacob&esau", 97],
  ["jacob", 97],
]);
export default CARD_MAP;