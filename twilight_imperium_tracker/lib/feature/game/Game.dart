import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Game.g.dart';

@JsonSerializable()
class Game {
  String key;
  Race raceUsed;
  int points;
  int goal;
  GameResult result;
  var opponents = <Race>[];

  Game({this.raceUsed, this.points, this.goal, this.result, this.opponents});

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);

  factory Game.fromSnapshot(DataSnapshot snapshot) =>
      Game.fromJson(Map<String, dynamic>.from(snapshot.value))..key = snapshot.key;

  Game copy({raceUsed, points, goal, result, opponents}) => Game(
      raceUsed: raceUsed ?? this.raceUsed,
      points: points ?? this.points,
      goal: goal ?? this.points,
      result: result ?? this.result,
      opponents: opponents ?? this.opponents);
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
  XXCHA_KINGDOM,
}

enum GameResult { WIN, LOSE, DRAW }
