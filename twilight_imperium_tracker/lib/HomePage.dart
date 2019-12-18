import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AddGamePage.dart';
import 'Game.dart';
import 'MyApp.dart';
import 'Translations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _games = <Game>[];
  DatabaseReference _gamesRef;

  @override
  void initState() {
    super.initState();
    _gamesRef = FirebaseDatabase.instance.reference().child(user.uid).child("games");
    _gamesRef.onChildAdded.listen(_onGameAdded);
    _gamesRef.onChildChanged.listen(_onGameChanged);
  }

  void _onGameAdded(Event event) {
    setState(() {
      _games.add(Game.fromJson(Map<String, dynamic>.from(event.snapshot.value)));
    });
  }

  void _onGameChanged(Event event) {
    var old = _games.singleWhere((game) {
      return game.key == event.snapshot.key;
    });
    setState(() {
      _games[_games.indexOf(old)] = Game.fromJson(Map<String, dynamic>.from(event.snapshot.value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: Text(Translations.of(context).text('home_page_title')),
      ),
      body: ListView.builder(
          itemCount: _games.length,
          padding: EdgeInsets.all(8.0),
          itemBuilder: (context, index) {
            return _buildRow(context, _games[index]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddGamePage()));
        },
        tooltip: Translations.of(context).text('add_new'),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildRow(BuildContext context, Game game) {
    return Card(
        color: _cardColor(game.result),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(getUserFriendlyRaceName(Translations.of(context), game.raceUsed)),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "${Translations.of(context).text('collected')} ${game.points} ${Translations.of(context).text('points')} ${Translations.of(context).text('goal_was')} ${game.goal}",
                  textAlign: TextAlign.left,
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: game.opponents.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0)
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("${Translations.of(context).text('opponents')}"),
                      );
                    return Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text("* ${getUserFriendlyRaceName(Translations.of(context), game.opponents[index - 1])}"),
                    );
                  })
            ],
          ),
        ));
  }

  Color _cardColor(GameResult result) {
    switch (result) {
      case GameResult.WIN:
        return Colors.lightGreenAccent;
      case GameResult.LOSE:
        return Colors.redAccent;
      case GameResult.DRAW:
        return Colors.grey;
    }
    return Colors.white;
  }
}
