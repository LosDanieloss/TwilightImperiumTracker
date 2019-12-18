import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AddGameBloc extends Bloc<AddGameEvent, AddGameState> {
  @override
  AddGameState get initialState => InitialAddGameState();

  @override
  Stream<AddGameState> mapEventToState(
    AddGameEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
