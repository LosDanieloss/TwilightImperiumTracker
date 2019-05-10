import 'package:flutter/material.dart';

import 'Game.dart';

class Games with ChangeNotifier {
  final _games = <Game>[];

  get games => _games;

  void add(Game game) {
    _games.add(game);
    notifyListeners();
  }
}