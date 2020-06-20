import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';
import 'package:twilight_imperium_tracker/repository/GamesRepository.dart';
import './bloc.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GamesRepository repository;

  GamesBloc({@required this.repository});

  @override
  GamesState get initialState {
    repository.getGames().listen((games) {
      add(GamesChangedEvent(games: games));
    });
    return InitialGamesBlocState();
  }

  @override
  Stream<GamesState> mapEventToState(GamesEvent event,) async* {
    if (event is AddNewGameEvent) {
      yield AddNewGameBlocState(games: state.games);
    }
    if (event is GamesChangedEvent) {
      yield LoadedGamesBlocState(games: event.games);
    }
    if (event is DeleteGameEvent) {
      repository.deleteGame(event.game);
    }
  }
}
