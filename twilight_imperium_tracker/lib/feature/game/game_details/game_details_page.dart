import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twilight_imperium_tracker/Translations.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';
import 'package:twilight_imperium_tracker/feature/game/GameResultExtension.dart';
import 'package:twilight_imperium_tracker/feature/game/RaceExtension.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0,),
        child: BlocListener(
          bloc: _bloc..add(StoreGameDetailsEvent(game: game)),
          child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is InitialGameDetailsState) {
                return Container();
              }
              if (state is LoadedGameDetailsState) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _buildResultIcon(context: context, result: game.result, translations: translations)
                      ..addAll([
                        _buildRace(context: context, translations: translations, raceUsed: game.raceUsed),
                        _buildCollectedPoints(
                            translations: translations, collectedPoints: game.points, goal: game.goal),
                        _buildRacesInPlayHeader(context: context, translations: translations),
                        _buildRaceBanner(context: context, translations: translations, race: game.raceUsed),
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

  List<Widget> _buildResultIcon({@required BuildContext context, @required GameResult result, @required Translations translations}) {
    return [
      Icon(
        result.getResultIcon(),
        color: result.getResultIconColor(),
        size: 128,
      ),
      Text(
        result.resultRationale(translations),
        style: Theme.of(context).textTheme.body1,
      )
    ];
  }

  Widget _buildRace({@required BuildContext context, @required Translations translations, @required Race raceUsed}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        "${translations.text('my_race')}"
        "${raceUsed.getUserFriendlyRaceName(translations)}",
        style: Theme.of(context).textTheme.headline,
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

  Widget _buildRacesInPlayHeader({@required BuildContext context, @required Translations translations}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(translations.text('race_used_game'), style: Theme.of(context).textTheme.subhead.merge(TextStyle(fontSize: 20))),
    );
  }

  Widget _buildRaceBanner({@required BuildContext context, @required Translations translations, @required Race race}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: <Widget>[
              race.getRaceImageBanner(),
              _buildRaceText(context: context, translations: translations, race: race),
            ],
          )),
    );
  }

  Widget _buildRaceText({@required BuildContext context, @required Translations translations, @required Race race}) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        color: Colors.black54,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    race.getUserFriendlyRaceName(translations),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subhead.merge(TextStyle(color: Colors.white)),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildOpponents({@required Translations translations, @required List<Race> opponents}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: opponents.length,
        itemBuilder: (context, index) {
          final race = opponents[index];
          return _buildRaceBanner(context: context, translations: translations, race: race);
        });
  }
}
