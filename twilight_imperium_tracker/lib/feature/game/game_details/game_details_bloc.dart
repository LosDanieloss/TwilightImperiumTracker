import 'package:bloc/bloc.dart';
import 'package:twilight_imperium_tracker/feature/game/game_details/bloc.dart';

class GameDetailsBloc extends Bloc<GameDetailsEvent, GameDetailsState> {

  @override
  GameDetailsState get initialState => InitialGameDetailsState();

  @override
  Stream<GameDetailsState> mapEventToState(GameDetailsEvent event) async* {
    if (event is StoreGameDetailsEvent) {
      yield LoadedGameDetailsState(game: event.game);
    }

    if (event is CloseEvent) {
      yield CloseState();
    }
  }
}