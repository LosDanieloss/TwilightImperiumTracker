import 'package:flutter/material.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';

@immutable
abstract class GameDetailsEvent {}

class StoreGameDetailsEvent extends GameDetailsEvent {
  final Game game;

  StoreGameDetailsEvent({ @required this.game });
}

class CloseEvent extends GameDetailsEvent {}