import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent {}

class AutoLoginEvent extends LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {}
