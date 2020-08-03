import 'package:flutter/material.dart';
import 'journal_edit_bloc.dart';
import 'package:journal/models/journal.dart';

class JournalEditBlocProvider extends InheritedWidget {
  final JournalEditBloc journalEditBloc;
  final bool add;
  final Journal journal;

  const JournalEditBlocProvider(
      {Key key, Widget child, this.journalEditBloc, this.add, this.journal})
      : super(key: key, child: child);

  static JournalEditBlocProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType()
        as JournalEditBlocProvider);
  }

  // check whether the journalEditBloc does not equal the old JournalEditBlocProvider
  @override
  bool updateShouldNotify(JournalEditBlocProvider old) => false;
}
