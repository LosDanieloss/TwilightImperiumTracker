import 'package:flutter/material.dart';

Future<T> pushScreen<T extends Object>(BuildContext context, Widget screen) {
  return Navigator.of(context).push<T>(MaterialPageRoute(builder: (context) => screen));
}

bool popScreen<T extends Object>(BuildContext context) {
  return Navigator.of(context).pop<T>();
}

void popUntil(BuildContext context, String screenName) {
  Navigator.of(context).popUntil(ModalRoute.withName(screenName));
}

Future<T> pushReplacementNamed<T extends Object, TO extends Object> (
  BuildContext context,
  String screenName, {
  Object arguments,
}) {
  return Navigator.of(context).pushReplacementNamed<T, TO>(screenName, arguments: arguments);
}

bool popWithResult<T>(BuildContext context, T value) {
  return Navigator.of(context).pop<T>(value);
}

Future<T> pushForResult<T>(BuildContext context, MaterialPageRoute<T> route) async {
  return Navigator.of(context).push(route);
}
