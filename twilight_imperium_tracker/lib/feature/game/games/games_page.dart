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
                child: (_games == null) ? CircularProgressIndicator() :ListView.builder(
                    itemCount: _games.length,
                    padding: EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      return _buildRow(context, _games[index]);
                    }),
              ),
              listener:  (context, state) {
                if (state is AddNewGameBlocState) {
                  pushScreenNamed(context, AddGamePage.route);
                }
              },
            );
          }
        ),
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
      child: Card(
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
                    "${Translations.of(context).text('collected')} "
                        "${game.points} ${Translations.of(context).text('points')} "
                        "${Translations.of(context).text('goal_was')} ${game.goal}",
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
          )
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
