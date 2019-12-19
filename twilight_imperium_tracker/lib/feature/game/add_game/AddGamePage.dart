import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:twilight_imperium_tracker/App.dart';
import 'package:twilight_imperium_tracker/Translations.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';
import 'package:twilight_imperium_tracker/feature/utils/Navigation.dart';

class AddGamePage extends StatefulWidget {

  static const route = "/games/new";

  @override
  _AddGamePageState createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  Game _game;
  DatabaseReference _gamesRef;

  @override
  void initState() {
    super.initState();
    _game = Game(opponents: []);
    _gamesRef = FirebaseDatabase.instance.reference().child(user.uid).child("games");
  }

  @override
  Widget build(BuildContext context) {
    final _translations = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: Text(_translations.text('home_page_title')),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Center(
                      child: Text(
                        _translations.text("pick_result"),
                        style: TextStyle(fontSize: 16),
                      )
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                        GameResult.values.length,
                            (int index) {
                          return Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Radio<GameResult>(
                                    value: GameResult.values[index],
                                    groupValue: _game.result,
                                    onChanged: (GameResult result) {
                                      setState(() {_game.result = GameResult.values[index]; });
                                    }),
                                GestureDetector(
                                  child: Text(getUserFriendlyResult(_translations, GameResult.values[index])),
                                  onTap: () { setState(() {_game.result = GameResult.values[index]; }); },
                                )
                              ]);
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(labelText: _translations.text('collected_points')),
                            keyboardType: TextInputType.number,
                            onChanged: (String collectedPoints) {
                              setState(() {
                                _game.points = int.parse(collectedPoints);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(labelText: _translations.text('goal_points')),
                            keyboardType: TextInputType.number,
                            onChanged: (String collectedPoints) {
                              setState(() {
                                _game.goal = int.parse(collectedPoints);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                          _translations.text("my_race"),
                          style: TextStyle(fontSize: 16),
                        )
                    ),
                  ),
                  Wrap(
                    children: List<Widget>.generate(
                        Race.values.length,
                            (int index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ChoiceChip(
                              label: Text(getUserFriendlyRaceName(_translations, Race.values[index])),
                              selected: _game.raceUsed == Race.values[index],
                              onSelected: (bool selected) { _manageRaceUsed(Race.values[index]); },
                            ),
                          );
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                          _translations.text("opponents"),
                          style: TextStyle(fontSize: 16),
                        )
                    ),
                  ),
                  Wrap(
                    children: List<Widget>.generate(
                        Race.values.length,
                        (int index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ChoiceChip(
                              label: Text(getUserFriendlyRaceName(_translations, Race.values[index])),
                              selected: _game.opponents.contains(Race.values[index])
                                  || _game.raceUsed == Race.values[index],
                              onSelected: (bool selected) { _manageOpponents(Race.values[index]); },
                            ),
                          );
                        }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {_saveGame(context, _game); },
        tooltip: Translations.of(context).text('add_new'),
        child: Icon(Icons.save),
      ),
    );
  }

  _manageRaceUsed(Race _race) {
    setState(() {
      if (!_game.opponents.contains(_race)) {
        _game.raceUsed = _race;
      }
    });
  }

  _manageOpponents(Race _race) {
    setState(() {
      if (_game.opponents.contains(_race)) {
        _game.opponents.remove(_race);
      } else if (_game.raceUsed != _race){
        _game.opponents.add(_race);
      }
    });
  }

  void _saveGame(BuildContext context, Game game) {
    _gamesRef.push().set(_game.toJson());
    popScreen(context);
  }
}
