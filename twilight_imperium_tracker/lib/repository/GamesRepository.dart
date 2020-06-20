
import 'package:twilight_imperium_tracker/feature/game/Game.dart';

abstract class GamesRepository {
  Stream<List<Game>> getGames();
}