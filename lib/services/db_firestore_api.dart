import 'package:journal/models/journal.dart';

abstract class DbApi {
  // Interface methods
  Stream<List<Journal>> getJournalList(String uid);
  Future<Journal> getJournal(String documentID);
  Future<bool> addJournal(Journal journal);
  void updateJournal(Journal journal);
  void updateJournalWithTransaction(Journal journal);
  void deleteJournal(Journal journal);
}
