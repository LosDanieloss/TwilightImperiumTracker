import 'package:flutter/material.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';

@immutable
abstract class GamesEvent {}

class LoadGamesEvent extends GamesEvent {}

class AddNewGameEvent extends GamesEvent {}

class ChangeGameEvent extends GamesEvent {}

class NewGameAddedEvent extends GamesEvent {}

class GamesChangedEvent extends GamesEvent {}

class DeleteGameEvent extends GamesEvent {

  final Game game;

  DeleteGameEvent({@required this.game});
}