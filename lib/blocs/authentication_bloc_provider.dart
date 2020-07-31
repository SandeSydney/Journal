import 'package:flutter/material.dart';
import 'authentication_bloc.dart';

// class to pass the State between widgets and pages
class AuthenticationBlocProvider extends InheritedWidget {
  final AuthenticationBloc authenticationBloc;

  const AuthenticationBlocProvider(
      {Key key, Widget child, this.authenticationBloc})
      : super(key: key, child: child);

  static AuthenticationBlocProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType()
        as AuthenticationBlocProvider);
  }

  // method to check if the authenticationBloc does not equal the old AuthenticationBlocProvider
  @override
  bool updateShouldNotify(AuthenticationBlocProvider old) =>
      authenticationBloc != old.authenticationBloc;
}
