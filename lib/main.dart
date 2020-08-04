import 'package:flutter/material.dart';
import 'package:journal/pages/home.dart';
import 'blocs/authentication_bloc.dart';
import 'blocs/authentication_bloc_provider.dart';
import 'blocs/home_bloc.dart';
import 'blocs/home_bloc_provider.dart';
import 'services/authentication.dart';
import 'services/db_firestore.dart';
import 'pages/login.dart';

// main method of the program
void main() => runApp(MyApp());

// root of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationService _authenticationService =
        AuthenticationService();
    final AuthenticationBloc _authenticationBloc =
        AuthenticationBloc(_authenticationService); // service injected

    return AuthenticationBlocProvider(
      authenticationBloc: _authenticationBloc,
      child: StreamBuilder(
        initialData: null, // no user is logged in
        stream: _authenticationBloc.user,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // display progress indicator while snapshot connection status is waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.lightGreen,
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return HomeBlocProvider(
              homeBloc: HomeBloc(DbFirestoreService(), _authenticationService),
              uid: snapshot.data,
              child: _buildMaterialApp(Home()), // navigate to home class page
            );
          } else {
            return _buildMaterialApp(Login());
          }
        },
      ),
    );
  }

  MaterialApp _buildMaterialApp(Widget homePage) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inherited Security',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        canvasColor: Colors.lightGreen.shade50,
        bottomAppBarColor: Colors.lightGreen,
      ),
      home: homePage,
    );
  }
}
