import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';
import 'package:twilight_imperium_tracker/repository/GamesRepository.dart';
import './bloc.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GamesRepository repository;
  List<Game> _games = [];

  GamesBloc({@required this.repository});

  @override
  GamesState get initialState {
    repository.getGames().listen((games) {
      _games = games;
      add(GamesChangedEvent());
    });
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
    if (event is GamesChangedEvent) {
      yield LoadedGamesBlocState(games: _games);
    }
    if (event is DeleteGameEvent) {
      final gameToDelete = event.game;
      repository.deleteGame(gameToDelete);
    }
  }
}
