import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twilight_imperium_tracker/Translations.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';
import 'package:twilight_imperium_tracker/feature/game/game_details/bloc.dart';
import 'package:twilight_imperium_tracker/feature/utils/Navigation.dart';

class GameDetailsArguments {
  final Game game;

  GameDetailsArguments({@required this.game});
}

class GameDetails extends StatelessWidget {
  static const route = "/games/game/details";

  final _bloc = GameDetailsBloc();

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    final game = (ModalRoute.of(context).settings.arguments as GameDetailsArguments).game;

    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: Text(translations.text('home_page_title')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener(
          bloc: _bloc..add(StoreGameDetailsEvent(game: game)),
          child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is InitialGameDetailsState) {
                return Container();
              }
              if (state is LoadedGameDetailsState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _buildResultIcon(context: context, result: game.result)
                      ..addAll([
                        _buildRace(context: context, translations: translations, raceUsed: game.raceUsed),
                        _buildCollectedPoints(
                            translations: translations, collectedPoints: game.points, goal: game.goal),
                        _buildOpponents(translations: translations, opponents: game.opponents),
                      ]),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
          listener: (context, state) {
            if (state is CloseState) {
              popScreen(context);
            }
          },
        ),
      ),
    );
  }

  List<Widget> _buildResultIcon({@required BuildContext context, @required GameResult result}) {
    return [
      Icon(
        getResultIcon(result),
        color: getResultIconColor(result),
        size: 128,
      ),
      Text(
        _resultRationale(result: result),
        style: Theme.of(context).textTheme.bodyText1,
      )
    ];
  }

  String _resultRationale({@required GameResult result}) {
    switch (result) {
      case GameResult.WIN:
        return "Congratulation! You have won.";
      case GameResult.DRAW:
        return "Not bad. It's a draw.";
      case GameResult.LOSE:
        return "Better luck next time.";
    }
  }

  Widget _buildRace({@required BuildContext context, @required Translations translations, @required Race raceUsed}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        "${translations.text('my_race')}"
        "${getUserFriendlyRaceName(translations, raceUsed)}",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildCollectedPoints(
      {@required Translations translations, @required int collectedPoints, @required int goal}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        "${translations.text('collected')} "
        "$collectedPoints ${translations.text('points')} "
        "${translations.text('goal_was')} $goal",
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildOpponents({@required Translations translations, @required List<Race> opponents}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: opponents.length + 1,
        itemBuilder: (context, index) {
          if (index == 0)
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text("${translations.text('opponents')}"),
            );
          return Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text("* ${getUserFriendlyRaceName(translations, opponents[index - 1])}"),
          );
        });
  }
}
