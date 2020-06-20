import 'package:twilight_imperium_tracker/feature/game/Game.dart';

abstract class GamesRepository {
  Future<void> prepareUser();
  Stream<List<Game>> getGames();
  Future<void> saveGame(Game game);
}