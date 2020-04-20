import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twilight_imperium_tracker/Translations.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';
import 'package:twilight_imperium_tracker/feature/game/add_game/add_game_page.dart';
import 'package:twilight_imperium_tracker/feature/game/game_details/game_details_page.dart';
import 'package:twilight_imperium_tracker/feature/game/games/bloc.dart';
import 'package:twilight_imperium_tracker/feature/utils/Navigation.dart';

class GamesPage extends StatefulWidget {
  static const route = "/games";

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  final _bloc = GamesBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: Text(Translations.of(context).text('home_page_title')),
      ),
      body: BlocProvider(
        create: (BuildContext context) => _bloc,
        child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              final _games = state.games;
              return BlocListener(
                bloc: _bloc,
                child: Center(
                  child: (_games == null)
                      ? CircularProgressIndicator()
                      : ListView.separated(
                          itemCount: _games.length,
                          padding: EdgeInsets.all(8.0),
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.grey,
                              ),
                          itemBuilder: (context, index) => _buildRow(context, _games[index])),
                ),
                listener: (context, state) {
                  if (state is AddNewGameBlocState) {
                    pushScreenNamed(context, AddGamePage.route);
                  }
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bloc.add(AddNewGameEvent()),
        tooltip: Translations.of(context).text('add_new'),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildRow(BuildContext context, Game game) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            getResultIcon(game.result),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      getUserFriendlyRaceName(Translations.of(context), game.raceUsed),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "Placeholder date: 26.10.2019", /* TODO date to game object */
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        pushScreenNamed(context, GameDetails.route, arguments: GameDetailsArguments(game: game));
      },
    );
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

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
