
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:twilight_imperium_tracker/feature/game/add_game/AddGamePage.dart';
import 'package:twilight_imperium_tracker/feature/game/games/games_page.dart';

import 'Translations.dart';
import 'feature/login/login_page.dart';

FirebaseUser user;

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TI4 Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('pl', ''),
      ],
      initialRoute: LoginPage.route,
      routes: {
        LoginPage.route: (_) => LoginPage(),
        GamesPage.route: (_) => GamesPage(),
        AddGamePage.route: (_) => AddGamePage(),
      },
    );
  }
}