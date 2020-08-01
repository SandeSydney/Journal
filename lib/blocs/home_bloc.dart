import 'dart:async';
import 'package:journal/services/authentication_api.dart';
import 'package:journal/services/db_firestore_api.dart';
import 'package:journal/models/journal.dart';

/// class identifies credentials of the logged in user and the
/// monitoring of the user's authentication login status
class HomeBloc {
  final DbApi dbApi;
  final AuthenticationApi authenticationApi;

  final StreamController<List<Journal>> _journalController =
      StreamController<List<Journal>>.broadcast();
  Sink<List<Journal>> get _addListJournal => _journalController.sink;
  Stream<List<Journal>> get listJournal => _journalController.stream;

  final StreamController<Journal> _journalDeleteController =
      StreamController<Journal>.broadcast();
  Sink<Journal> get deleteJournal => _journalDeleteController.sink;
  // stream not needed since the StreamController is responsible for deleting journals

  // inject DbFirestoreService and AuthenticationService classes
  HomeBloc(this.dbApi, this.authenticationApi) {
    _startListeners();
  }

  // dispose method
  void dispose() {
    _journalController.close();
    _journalDeleteController.close();
  }

  // method to set up listeners to retrieve a list of journals and delete an entry
  void _startListeners() {
    // retrieve currenty logged in user uid
    authenticationApi.getFirebaseAuth().currentUser().then((user) {
      dbApi.getJournalList(user.uid).listen((journalDocs) {
        _addListJournal.add(journalDocs);
      });

      // return the journal to be deleted
      _journalDeleteController.stream.listen((journal) {
        dbApi.deleteJournal(journal);
      });
    });
  }
}
