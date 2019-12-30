import 'package:meta/meta.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';

@immutable
abstract class GamesState {
  final List<Game> games;

  GamesState({this.games});
}

class InitialGamesBlocState extends GamesState {}

class LoadedGamesBlocState extends GamesState {

  LoadedGamesBlocState({games}) : super(games: games);
}

class AddNewGameBlocState extends GamesState {

  AddNewGameBlocState({List<Game> games}) : super(games: games);
}
