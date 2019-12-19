import 'package:meta/meta.dart';

@immutable
abstract class GamesEvent {}

class LoadGamesEvent extends GamesEvent {}

class AddNewGameEvent extends GamesEvent {}

class ChangeGameEvent extends GamesEvent {}

class NewGameAddedEvent extends GamesEvent {}

class GameChangedEvent extends GamesEvent {}