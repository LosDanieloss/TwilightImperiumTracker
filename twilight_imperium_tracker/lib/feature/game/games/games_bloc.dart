import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  @override
  GamesState get initialState => InitialGamesBlocState();

  @override
  Stream<GamesState> mapEventToState(
    GamesEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
