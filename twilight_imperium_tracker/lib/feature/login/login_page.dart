import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twilight_imperium_tracker/Translations.dart';
import 'package:twilight_imperium_tracker/feature/game/games/Games.dart';
import 'package:twilight_imperium_tracker/feature/login/bloc.dart';
import 'package:twilight_imperium_tracker/feature/utils/Navigation.dart';

class LoginPage extends StatefulWidget {
  static const route = "/";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => _bloc,
      child: BlocListener(
        bloc: _bloc,
        child: Scaffold(
                appBar: AppBar(
                  elevation: 8,
                  centerTitle: true,
                  title: Text(Translations.of(context).text('home_page_title')),
                ),
                body: BlocBuilder(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is InitialLoginState) {
                      _bloc.add(AutoLoginEvent());
                    }
                    if (state is LoginInProgressState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Center(
                      child: RaisedButton(
                          child: Text(Translations.of(context).text('login')),
                          onPressed: () => _bloc.add(LoginButtonClickedEvent())),
                    );
                  }
                ),
              ),
        listener: (context, state) {
          if (state is LoginSuccessfulState) {
            pushReplacementNamed(context, GamesPage.route);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
