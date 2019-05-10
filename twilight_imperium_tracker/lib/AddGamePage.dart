import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Game.dart';
import 'Games.dart';
import 'Translations.dart';

class AddGamePage extends StatefulWidget {

  @override
  _AddGamePageState createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  final _game = Game(opponents: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: Text(Translations.of(context).text('home_page_title')),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: <Widget>[
                      Text(Translations.of(context).text('my_race')),
                      DropdownButton<Race>(
                        value: _game.raceUsed,
                        onChanged: (Race newRace) {
                          setState(() {
                            _game.raceUsed = newRace;
                          });
                        },
                        items: Race.values.map((Race race) {
                          return DropdownMenuItem<Race>(
                            value: race,
                            child: Text(race.toString()),
                          );
                        }).toList(),
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
                          decoration: InputDecoration(labelText: Translations.of(context).text('collected_points')),
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
                          decoration: InputDecoration(labelText: Translations.of(context).text('goal_points')),
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
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: <Widget>[
                      Text("${Translations.of(context).text('winner') }"),
                      DropdownButton<Race>(
                        value: _game.gameWinner,
                        onChanged: (Race newRace) {
                          setState(() {
                            _game.gameWinner = newRace;
                          });
                        },
                        items: Race.values.map((Race race) {
                          return DropdownMenuItem<Race>(
                            value: race,
                            child: Text(race.toString()),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Radio<GameResult>(
                        value: GameResult.WIN,
                        groupValue: _game.result,
                        onChanged: (GameResult result) {
                          setState(() {
                            _game.result = result;
                          });
                        }
                      ),
                      Text(GameResult.WIN.toString().substring(11)),
                      Radio<GameResult>(
                        value: GameResult.DRAW,
                        groupValue: _game.result,
                        onChanged: (GameResult result) {
                          setState(() {
                            _game.result = result;
                          });
                        }
                      ),
                      Text(GameResult.DRAW.toString().substring(11)),
                      Radio<GameResult>(
                        value: GameResult.LOSE,
                        groupValue: _game.result,
                        onChanged: (GameResult result) {
                          setState(() {
                            _game.result = result;
                          });
                        }
                      ),
                      Text(GameResult.LOSE.toString().substring(11))
                    ],
                  ),
                )
              ],
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

  void _saveGame(BuildContext context, Game game) {
    final _games = Provider.of<Games>(context);
    _games.add(game);
    Navigator.pop(context);
  }
}
