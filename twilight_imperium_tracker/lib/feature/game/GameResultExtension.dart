import 'package:flutter/material.dart';
import 'package:twilight_imperium_tracker/Translations.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';

extension GameResultExtension on GameResult {
  String getUserFriendlyResult(Translations translations) {
    switch (this) {
      case GameResult.WIN:
        return translations.text('win');
      case GameResult.DRAW:
        return translations.text('draw');
      case GameResult.LOSE:
        return translations.text('lose');
    }
    throw Exception("Not supported GameResult");
  }

  IconData getResultIcon() {
    switch (this) {
      case GameResult.WIN:
        return Icons.star;
      case GameResult.DRAW:
        return Icons.star_half;
      case GameResult.LOSE:
        return Icons.star_border;
    }
    throw Exception("Not supported GameResult");
  }

  Color getResultIconColor() {
    switch (this) {
      case GameResult.WIN:
        return Colors.amber;
      case GameResult.DRAW:
        return Colors.grey;
      case GameResult.LOSE:
        return Colors.red;
    }
    throw Exception("Not supported GameResult");
  }

  String resultRationale(Translations translations) {
    switch (this) {
      case GameResult.WIN:
        return translations.text('game_result_rationale_won');
      case GameResult.DRAW:
        return translations.text('game_result_rationale_draw');
      case GameResult.LOSE:
        return translations.text('game_result_rationale_lose');
    }
    throw Exception("Not supported GameResult");
  }
}