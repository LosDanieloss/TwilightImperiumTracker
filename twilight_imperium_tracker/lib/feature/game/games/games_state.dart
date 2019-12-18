import 'package:equatable/equatable.dart';

abstract class GamesState extends Equatable {
  const GamesState();
}

class InitialGamesBlocState extends GamesState {
  @override
  List<Object> get props => [];
}
