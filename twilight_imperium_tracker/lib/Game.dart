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
