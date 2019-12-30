import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twilight_imperium_tracker/App.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginBlocState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  LoginBlocState get initialState => InitialLoginState();

  @override
  Stream<LoginBlocState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonClickedEvent || event is AutoLoginEvent) {
      yield LoginInProgressState();
      yield await _handleLoginButtonClicked();
    }
  }

  _handleLoginButtonClicked() async {
    try {
      await _handleSignIn();
      return LoginSuccessfulState();
    } catch (e) {
      print(e);
      return LoginFailedState();
    }
  }

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return user;
  }
}
