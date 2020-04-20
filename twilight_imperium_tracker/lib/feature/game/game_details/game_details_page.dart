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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "${translations.text('my_race')}"
                          "${getUserFriendlyRaceName(translations, game.raceUsed)}",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "${translations.text('collected')} "
                          "${game.points} ${translations.text('points')} "
                          "${translations.text('goal_was')} ${game.goal}",
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
                                child: Text("${translations.text('opponents')}"),
                              );
                            return Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text("* ${getUserFriendlyRaceName(translations, game.opponents[index - 1])}"),
                            );
                          })
                    ],
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
