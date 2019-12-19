import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:twilight_imperium_tracker/App.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';
import './bloc.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final List<Game> _games = [];
  DatabaseReference _gamesRef;

  @override
  GamesState get initialState {
    _gamesRef = FirebaseDatabase.instance.reference().child(user.uid).child("games");
    _gamesRef.onChildAdded.listen(_onGameAdded);
    _gamesRef.onChildChanged.listen(_onGameChanged);
    return InitialGamesBlocState();
  }

  @override
  Stream<GamesState> mapEventToState(GamesEvent event,) async* {
    if (event is LoadGamesEvent) {
      yield LoadedGamesBlocState(games: _games);
    }
    if (event is AddNewGameEvent) {
      yield AddNewGameBlocState(games: state.games);
    }
    if (event is NewGameAddedEvent || event is GameChangedEvent) {
      yield LoadedGamesBlocState(games: _games);
    }
  }

  void _onGameAdded(Event event) {
    _games.add(Game.fromJson(Map<String, dynamic>.from(event.snapshot.value)));
    add(NewGameAddedEvent());
  }

  _onGameChanged(Event event) {
    var old = _games.singleWhere((game) {
      return game.key == event.snapshot.key;
    });
    _games[_games.indexOf(old)] = Game.fromJson(Map<String, dynamic>.from(event.snapshot.value));
    add(GameChangedEvent());
  }
}
