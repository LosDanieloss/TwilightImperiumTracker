import 'package:meta/meta.dart';

@immutable
abstract class LoginBlocState {}

class InitialLoginState extends LoginBlocState {}

class LoginInProgressState extends LoginBlocState {}

class LoginSuccessfulState extends LoginBlocState {}

class LoginFailedState extends LoginBlocState {}
