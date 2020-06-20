import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twilight_imperium_tracker/Translations.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';
import 'package:twilight_imperium_tracker/feature/game/GameResultExtension.dart';
import 'package:twilight_imperium_tracker/feature/game/RaceExtension.dart';
import 'package:twilight_imperium_tracker/feature/game/add_game/add_game_bloc.dart';
import 'package:twilight_imperium_tracker/feature/game/add_game/add_game_event.dart';
import 'package:twilight_imperium_tracker/feature/game/add_game/add_game_state.dart';
import 'package:twilight_imperium_tracker/feature/utils/Navigation.dart';

class AddGamePage extends StatefulWidget {
  static const route = "/games/new";

  @override
  _AddGamePageState createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  AddGameBloc _bloc;

  @override
  Widget build(BuildContext context) {
    final _translations = Translations.of(context);
    _bloc = AddGameBloc(repository: RepositoryProvider.of(context));

    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: Text(_translations.text('home_page_title')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocListener(
                bloc: _bloc,
                child: BlocBuilder(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is GameAdded) {
                      return Container();
                    }
                    return Column(
                        children: _buildResult(state.game.result, _translations)
                          ..add(_buildCollectedPoints(state.game.points, _translations))
                          ..add(_buildGoalPoints(state.game.goal, _translations))
                          ..addAll(_buildRaceUsed(state.game.raceUsed, _translations))
                          ..addAll(_buildOpponentsRace(state.game.raceUsed, state.game.opponents, _translations)));
                  },
                ),
                listener: (context, state) {
                  if (state is GameAdded) {
                    popScreen(context);
                  }
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bloc.add(SaveGame());
        },
        tooltip: Translations.of(context).text('add_new'),
        child: Icon(Icons.save),
      ),
    );
  }

  List<Widget> _buildResult(GameResult result, Translations translations) => [
        Center(
            child: Text(
          translations.text("pick_result"),
          style: TextStyle(fontSize: 16),
        )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(GameResult.values.length, (int index) {
            final gameResult = GameResult.values[index];
            return Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: <Widget>[
              Radio<GameResult>(
                  value: GameResult.values[index],
                  groupValue: result,
                  onChanged: (GameResult result) {
                    _bloc.add(GameResultChosen(result: GameResult.values[index]));
                  }),
              GestureDetector(
                child: Text(gameResult.getUserFriendlyResult(translations)),
                onTap: () {
                  _bloc.add(GameResultChosen(result: GameResult.values[index]));
                },
              )
            ]);
          }),
        )
      ];

  Widget _buildCollectedPoints(int points, Translations translations) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: translations.text('collected_points')),
                keyboardType: TextInputType.number,
                onChanged: (String collectedPoints) {
                  _bloc.add(CollectedPoints(points: int.parse(collectedPoints)));
                },
              ),
            )
          ],
        ),
      );

  Widget _buildGoalPoints(int goal, Translations translations) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: translations.text('goal_points')),
                keyboardType: TextInputType.number,
                onChanged: (String goalPoints) {
                  _bloc.add(GoalSet(goal: int.parse(goalPoints)));
                },
              ),
            )
          ],
        ),
      );

  List<Widget> _buildRaceUsed(Race raceUsed, Translations translations) => [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            translations.text("my_race"),
            style: TextStyle(fontSize: 16),
          )),
        ),
        Wrap(
          children: List<Widget>.generate(Race.values.length, (int index) {
            final race = Race.values[index];
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: ChoiceChip(
                label: Text(race.getUserFriendlyRaceName(translations)),
                selected: raceUsed == Race.values[index],
                onSelected: (bool selected) {
                  _bloc.add(RaceUsedPicked(race: Race.values[index]));
                },
              ),
            );
          }),
        )
      ];

  List<Widget> _buildOpponentsRace(Race raceUsed, List<Race> opponents, Translations translations) => [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            translations.text("opponents"),
            style: TextStyle(fontSize: 16),
          )),
        ),
        Wrap(
          children: List<Widget>.generate(Race.values.length, (int index) {
            final race = Race.values[index];
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: ChoiceChip(
                label: Text(race.getUserFriendlyRaceName(translations)),
                selected: opponents?.contains(Race.values[index]) == true || raceUsed == Race.values[index],
                onSelected: (bool selected) {
                  _bloc.add(OpponentRaceToggled(race: Race.values[index]));
                },
              ),
            );
          }),
        )
      ];

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
