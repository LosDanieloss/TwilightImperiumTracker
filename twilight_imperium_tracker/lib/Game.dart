import 'Translations.dart';

class Game {
  Race raceUsed;
  int points;
  int goal;
  GameResult result;
  Race gameWinner;
  var opponents = <Race>[];


  Game({ this.raceUsed, this.points, this.goal, this.result, this.gameWinner, this.opponents });
}

enum Race {
  ARBOREC,
  EMBERS_OF_MUAAT,
  GHOSTS_OF_CREUSS,
  NAALU_COLLECTIVE,
  UNIVERSITIES_OF_JOL_NAR,
  YIN_BROTHERHOOD,
  BARONY_OF_LETNEV,
  EMIRATES_OF_HACAN,
  L1Z1X_MINDNET,
  NEKRO_VIRUS,
  WINNU,
  YSSARIL_TRIBES,
  CLAN_OF_SAAR,
  FEDERATION_OF_SOL,
  Mentak_Coalition,
  SARDAKK_N_ORR,
  XXCHA_KINGDOM
}

enum GameResult {
  WIN,
  LOSE,
  DRAW
}

String getUserFriendlyRaceName(Translations translations, Race race) {
  switch(race) {
    case Race.ARBOREC:
      return translations.text('arborec');
    case Race.EMBERS_OF_MUAAT:
      return translations.text('embers_of_muaat');
    case Race.GHOSTS_OF_CREUSS:
      return translations.text('ghosts_of_creuss');
    case Race.NAALU_COLLECTIVE:
      return translations.text('naalu_collective');
    case Race.UNIVERSITIES_OF_JOL_NAR:
      return translations.text('universities_of_jol_nar');
    case Race.YIN_BROTHERHOOD:
      return translations.text('yin_brotherhood');
    case Race.BARONY_OF_LETNEV:
      return translations.text('barony_of_letnev');
    case Race.EMIRATES_OF_HACAN:
      return translations.text('emirates_of_hacan');
    case Race.L1Z1X_MINDNET:
      return translations.text('l1z1x_mindnet');
    case Race.NEKRO_VIRUS:
      return translations.text('nekro_virus');
    case Race.WINNU:
      return translations.text('winnu');
    case Race.YSSARIL_TRIBES:
      return translations.text('yssaril_tribes');
    case Race.CLAN_OF_SAAR:
      return translations.text('clan_of_saar');
    case Race.FEDERATION_OF_SOL:
      return translations.text('federation_of_sol');
    case Race.Mentak_Coalition:
      return translations.text('mentak_coalition');
    case Race.SARDAKK_N_ORR:
      return translations.text('sardakk_n_orr');
    case Race.XXCHA_KINGDOM:
      return translations.text('xxcha_kingdom');
  }
}

String getUserFriendlyResult(Translations translations, GameResult result) {
  switch(result) {
    case GameResult.WIN:
      return translations.text('win');
    case GameResult.DRAW:
      return translations.text('draw');
    case GameResult.LOSE:
      return translations.text('lose');
  }
}