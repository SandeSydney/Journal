import 'dart:async';
import 'package:journal/services/authentication_api.dart';

// this class calls the Firebase Auth service to login or logout a user
class AuthenticationBloc {
  final AuthenticationApi authenticationApi;

  final StreamController<String> _authenticationController =
      StreamController<String>();
  Sink<String> get addUser => _authenticationController.sink;
  Stream<String> get user => _authenticationController.stream;

  StreamController<bool> _logoutController = StreamController<bool>();
  Sink<bool> get logoutUser => _logoutController.sink;
  Stream<bool> get listLogoutUser => _logoutController.stream;

  AuthenticationBloc(this.authenticationApi) {
    onAuthChanged();
  }

  void dispose() {
    _authenticationController.close();
    _logoutController.close();
  }

  // method setting up a listener to monitor the login or logout
  void onAuthChanged() {
    // get FirebaseAuth.instance from authentication service class
    authenticationApi.getFirebaseAuth().onAuthStateChanged.listen((user) {
      final String uid = user != null ? user.uid : null;
      addUser.add(uid); // add the supplied value to the sink
    }); // set up the listener
    _logoutController.stream.listen((logout) {
      if (logout == true) {
        _signOut();
      }
    });
  }

  // method that calls a service to logout the user
  void _signOut() {
    authenticationApi.signOut();
  }
}
