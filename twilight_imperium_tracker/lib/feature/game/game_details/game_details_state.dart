import 'package:flutter/material.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';

@immutable
abstract class GameDetailsState {}

class InitialGameDetailsState extends GameDetailsState {}

class LoadedGameDetailsState extends GameDetailsState {
  final Game game;

  LoadedGameDetailsState({ @required this.game });
}

class CloseState extends GameDetailsState {}