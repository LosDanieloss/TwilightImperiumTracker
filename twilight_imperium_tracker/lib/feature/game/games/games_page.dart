import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:twilight_imperium_tracker/Translations.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';
import 'package:twilight_imperium_tracker/feature/game/GameResultExtension.dart';
import 'package:twilight_imperium_tracker/feature/game/RaceExtension.dart';
import 'package:twilight_imperium_tracker/feature/game/add_game/add_game_page.dart';
import 'package:twilight_imperium_tracker/feature/game/game_details/game_details_page.dart';
import 'package:twilight_imperium_tracker/feature/game/games/bloc.dart';
import 'package:twilight_imperium_tracker/feature/utils/Navigation.dart';
import 'package:twilight_imperium_tracker/repository/FirebaseGamesRepository.dart';

class GamesPage extends StatefulWidget {
  static const route = "/games";

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  final _bloc = GamesBloc(repository: FirebaseGamesRepository());
  final _datePattern = "dd.MM.yyyy";

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
                      : ListView.builder(
                          itemCount: _games.length,
                          padding: EdgeInsets.all(8.0),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildGameResultIcon(game.result),
                _buildGameInfo(game),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildViewDetails(context: context, game: game),
                Spacer(),
                _buildEdit(context: context, game: game),
                _buildDelete(context: context, game: game),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGameResultIcon(GameResult result) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        result.getResultIcon(),
        color: result.getResultIconColor(),
      ),
    );
  }

  Widget _buildGameInfo(Game game) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildRaceUsed(game.raceUsed),
          _buildDate(DateTime.now()), /* TODO date to game object */
        ],
      ),
    );
  }

  Widget _buildRaceUsed(Race raceUsed) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        raceUsed.getUserFriendlyRaceName(Translations.of(context)),
        style: Theme.of(context).textTheme.subhead,
      ),
    );
  }

  Widget _buildDate(DateTime date) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        "${DateFormat(_datePattern).format(date.toLocal())}",
        style: TextStyle(color: Colors.grey),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildViewDetails({@required BuildContext context, @required Game game}) {
    final translations = Translations.of(context);
    return FlatButton(
      textColor: Theme.of(context).accentColor,
      onPressed: () {
        pushScreenNamed(context, GameDetails.route, arguments: GameDetailsArguments(game: game));
      },
      child: Text(translations.text('view_details')),
    );
  }

  Widget _buildEdit({@required BuildContext context, @required Game game}) {
    return IconButton(
      iconSize: 20,
      color: Colors.grey,
      icon: Icon(Icons.edit),
      onPressed: () {
        /* TODO move user to edit*/
        Fluttertoast.showToast(
          msg: "Not implemented",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
    );
  }

  Widget _buildDelete({@required BuildContext context, @required Game game}) {
    return IconButton(
      iconSize: 20,
      color: Colors.grey,
      icon: Icon(Icons.delete),
      onPressed: () {
        /* TODO show dialog asking if user is sure */
        Fluttertoast.showToast(
          msg: "Not implemented",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
