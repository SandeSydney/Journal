import 'dart:async';
import 'package:journal/services/db_firestore_api.dart';
import 'package:journal/models/journal.dart';

JournalEditBloc(this.add, this.selectedJournal, this.dbApi) {
  final DbApi dbApi;
  final bool add;
  Journal selectedJournal;

  // StreamController to handle date
  final StreamController<String> _dateController =
      StreamController<String>.broadcast(); // for multiple listeners
  Sink<String> get dateEditChanged => _dateController.sink;
  Stream<String> get dateEdit => _dateController.stream;

  // StreamController to handle mood
  final StreamController<String> _moodController = 
      StreamController<String>.broadcast();
  Sink<String> get moodEditChanged => _moodController.sink;
  Stream<String> get moodEdit => _moodController.stream;

  // StreamController to handle note
  final StreamController<String> _noteController =
      StreamController<String>.broadcast();
  Sink<String> get noteEditChanged => _noteController.sink;
  Stream<String> get noteEdit => _noteController.stream;

  // StreamController to handle save
  final StreamController<String> _saveJournalController = 
      StreamController<String>.broadcast();
  Sink<String> get saveJournalChanged => _saveJournalController.sink;
  Stream<String> get saveJournal => _saveJournalController.stream;

  // constructor receiving params
  JournalEditBloc(this.add, this.selectedJournal, this.dbApi){
    _startEditListeners().then((finished) => _getJournal(add, selectedJournal));
  }

  // dispose method
  void dispose(){
    _dateController.close();
    _moodController.close();
    _noteController.close();
    _saveJournalController.close();
  }

  // asyncronous method responsible for setting up listeners
  Future<bool> _startEditListeners() async{
    _dateController.stream.listen((date) { 
      selectedJournal.date = date;
    });
    _moodController.stream.listen((mood) { 
      selectedJournal.mood = mood;
    });
    _noteController.stream.listen((note) { 
      selectedJournal.note = note;
    });
    _saveJournalController.stream.listen((action) { 
      if (action == 'Save'){
        _saveJournal();
      }
    });
    return true;
  }

  // method to get the journal
  void _getJournal(bool add, Journal journal){
    // check if the add value is true
    if (add) {
      selectedJournal = Journal();
      selectedJournal.date = DateTime.now().toString();
      selectedJournal.mood = 'Very Satisfied';
      selectedJournal.note = '';
      selectedJournal.uid = journal.uid;
    } else{
      // editing an existing entry
      selectedJournal.date = journal.date;
      selectedJournal.mood = journal.mood;
      selectedJournal.note = journal.note;
    } 
    dateEditChanged.add(selectedJournal.date);
    moodEditChanged.add(selectedJournal.mood);
    noteEditChanged.add(selectedJournal.note);
  }

  // save the journal
  void _saveJournal(){
    Journal journal = Journal(
      documentID: selectedJournal.documentID,
      date: DateTime.parse(selectedJournal.date).toIso8601String(),
      mood: selectedJournal.mood,
      note: selectedJournal.note,
      uid: selectedJournal.uid,
    );
    add ? dbApi.addJournal(journal) : dbApi.updateJournal(journal);
  }
}
