import 'package:meta/meta.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';

@immutable
abstract class AddGameEvent {}

class GameResultChosen extends AddGameEvent {
  final GameResult result;

  GameResultChosen({this.result});
}

class CollectedPoints extends AddGameEvent {
  final int points;

  CollectedPoints({this.points});
}

class GoalSet extends AddGameEvent {
  final int goal;

  GoalSet({this.goal});
}

class RaceUsedPicked extends AddGameEvent {
  final Race race;

  RaceUsedPicked({this.race});
}

class OpponentRaceToggled extends AddGameEvent {
  final Race race;

  OpponentRaceToggled({this.race});
}

class SaveGame extends AddGameEvent {}