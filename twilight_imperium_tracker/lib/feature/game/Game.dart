import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twilight_imperium_tracker/Translations.dart';

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

  Game.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        raceUsed = Race.values[snapshot.value["raceUsed"]],
        points = snapshot.value["points"],
        goal = snapshot.value["goal"],
        result = GameResult.values[snapshot.value["result"]],
        opponents = snapshot.value["opponents"];

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
