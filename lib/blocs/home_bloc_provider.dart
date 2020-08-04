import 'package:flutter/material.dart';
import 'home_bloc.dart';

class HomeBlocProvider extends InheritedWidget {
  // class variables
  final HomeBloc homeBloc;
  final String uid;

  // constructor
  const HomeBlocProvider({Key key, Widget child, this.homeBloc, this.uid})
      : super(key: key, child: child);

  static HomeBlocProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType() as HomeBlocProvider);
  }

  // check whether the homeBloc does not equal to the old HomeBlocProvider
  @override
  bool updateShouldNotify(HomeBlocProvider old) => homeBloc != old.homeBloc;
}
