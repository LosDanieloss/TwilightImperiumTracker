import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:twilight_imperium_tracker/App.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';
import 'package:twilight_imperium_tracker/repository/GamesRepository.dart';

class FirebaseGamesRepository implements GamesRepository {
  final StreamController<List<Game>> _gamesStream = StreamController()..add([]);
  final List<Game> _games = [];
  DatabaseReference _gamesRef;

  @override
  Future<void> prepareUser() {
    _gamesRef = FirebaseDatabase.instance.reference().child(user.uid).child("games");
    _gamesRef.onChildAdded.listen(_onGameAdded);
    _gamesRef.onChildChanged.listen(_onGameChanged);
    _gamesRef.onChildRemoved.listen(_onGameRemoved);
    return Future.value();
  }

  void _onGameAdded(Event event) {
    _games.add(Game.fromSnapshot(event.snapshot));
    _gamesStream.add(_games);
  }

  _onGameChanged(Event event) {
    var old = _games.singleWhere((game) {
      return game.key == event.snapshot.key;
    });
    _games[_games.indexOf(old)] = Game.fromSnapshot(event.snapshot);
    _gamesStream.add(_games);
  }

  _onGameRemoved(Event event) {
    var removedGame = _games.singleWhere((game) {
      return game.key == event.snapshot.key;
    });
    _games.remove(removedGame);
    _gamesStream.add(_games);
  }

  @override
  Stream<List<Game>> getGames() {
    return _gamesStream.stream;
  }

  @override
  Future<void> saveGame(Game game) {
    return _gamesRef.push().set(game.toJson());
  }

  @override
  Future<void> deleteGame(Game game) {
    return _gamesRef.child(game.key).remove();
  }
}
