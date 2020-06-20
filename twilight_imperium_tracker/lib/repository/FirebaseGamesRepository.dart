
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:twilight_imperium_tracker/App.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';
import 'package:twilight_imperium_tracker/repository/GamesRepository.dart';

class FirebaseGamesRepository implements GamesRepository {

  final DatabaseReference _gamesRef = FirebaseDatabase.instance.reference().child(user.uid).child("games");
  final StreamController<List<Game>> _gamesStream = StreamController();
  final List<Game> _games = [];

  FirebaseGamesRepository() {
    _gamesRef.onChildAdded.listen(_onGameAdded);
    _gamesRef.onChildChanged.listen(_onGameChanged);
  }

  @override
  Stream<List<Game>> getGames() {
    return _gamesStream.stream;
  }

  void _onGameAdded(Event event) {
    _games.add(Game.fromJson(Map<String, dynamic>.from(event.snapshot.value)));
    _gamesStream.add(_games);
  }

  _onGameChanged(Event event) {
    var old = _games.singleWhere((game) {
      return game.key == event.snapshot.key;
    });
    _games[_games.indexOf(old)] = Game.fromJson(Map<String, dynamic>.from(event.snapshot.value));
    _gamesStream.add(_games);
  }
}