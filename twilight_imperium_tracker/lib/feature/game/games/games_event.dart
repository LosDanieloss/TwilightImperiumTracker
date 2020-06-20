import 'package:flutter/material.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';

@immutable
abstract class GamesEvent {}

class AddNewGameEvent extends GamesEvent {}

class GamesChangedEvent extends GamesEvent {
  final List<Game> games;

  GamesChangedEvent({@required this.games});
}

class DeleteGameEvent extends GamesEvent {
  final Game game;

  DeleteGameEvent({@required this.game});
}