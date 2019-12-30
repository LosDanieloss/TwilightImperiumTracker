import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:twilight_imperium_tracker/App.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';
import 'package:twilight_imperium_tracker/feature/game/add_game/add_game_event.dart';
import 'package:twilight_imperium_tracker/feature/game/add_game/add_game_state.dart';
import './bloc.dart';

class AddGameBloc extends Bloc<AddGameEvent, AddGameState> {
  DatabaseReference _gamesRef = FirebaseDatabase.instance.reference().child(user.uid).child("games");

  @override
  AddGameState get initialState => AddGameInProgressState(game: Game());

  @override
  Stream<AddGameState> mapEventToState(
    AddGameEvent event,
  ) async* {
    if (event is GameResultChosen) {
      yield state.copy(state.game.copy(result: event.result));
    }

    if (event is CollectedPoints) {
      yield state.copy(state.game.copy(points: event.points));
    }

    if (event is GoalSet) {
      yield state.copy(state.game.copy(goal: event.goal));
    }

    if (event is RaceUsedPicked) {
      yield _updateRaceUsed(event.race);
    }

    if (event is OpponentRaceToggled) {
      yield _updateOpponentsRace(event.race);
    }

    if (event is SaveGame) {
      _saveGame();
      yield GameAdded();
    }
  }

  AddGameState _updateRaceUsed(Race race) {
    return state.game.opponents?.contains(race) == true ? state
        : state.copy(state.game.copy(raceUsed: race));
  }

  AddGameState _updateOpponentsRace(Race race) {
    if (state.game.raceUsed == race) {
      return state;
    }
    final newOpponents = state.game.opponents ?? <Race>[];
    newOpponents.contains(race) ? newOpponents.remove(race) : newOpponents.add(race);
    return state.copy(state.game.copy(opponents: newOpponents));
  }

  void _saveGame() {
    _gamesRef.push().set(state.game.toJson());
  }
}
