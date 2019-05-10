import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AddGamePage.dart';
import 'Game.dart';
import 'Games.dart';
import 'Translations.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _games = Provider.of<Games>(context).games;

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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddGamePage()));
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
                child: Text(game.raceUsed.toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "${Translations.of(context).text('collected')} ${game.points} ${Translations.of(context).text('points')} ${Translations.of(context).text('goal_was')}: ${game.goal}",
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                    "${Translations.of(context).text('winner')} ${game.gameWinner}"),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: game.opponents.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0)
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                            "${Translations.of(context).text('opponents')}"),
                      );
                    return Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text("* ${game.opponents[index - 1]}"),
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
