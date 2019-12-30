import 'package:meta/meta.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';

@immutable
abstract class AddGameState {
  final Game game;

  AddGameState({this.game});

  AddGameState copy(Game game);
}

class AddGameInProgressState extends AddGameState {

  AddGameInProgressState({Game game}): super(game: game);

  @override
  AddGameState copy(Game game) =>
      AddGameInProgressState(game: game ?? this.game.copy());
}

class GameAdded extends AddGameState {

  @override
  AddGameState copy(Game game) =>
      GameAdded();
}
