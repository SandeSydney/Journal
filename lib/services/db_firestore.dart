import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal/models/journal.dart';
import 'db_firestore_api.dart';

class DbFirestoreService implements DbApi {
  final Firestore _firestore = Firestore.instance;
  final String _collectionJournals = 'journals';

  DbFirestoreService() {
    _firestore.settings(timestampsInSnapshotsEnabled: true);
  }

  // retrieve journal entries
  Stream<List<Journal>> getJournalList(String uid) {
    return _firestore
        .collection(_collectionJournals)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<Journal> _journalDocs =
          snapshot.documents.map((doc) => Journal.fromDoc(doc)).toList();
      // sort in descending order
      _journalDocs.sort((comp1, comp2) => comp2.date.compareTo(comp1.date));
      return _journalDocs;
    });
  }

  // Adding a new entry
  Future<bool> addJournal(Journal journal) async {
    DocumentReference _documentReference =
        await _firestore.collection(_collectionJournals).add({
      'date': journal.date,
      'mood': journal.mood,
      'note': journal.note,
      'uid': journal.uid,
    });
    return _documentReference.documentID != null;
  }

  // Update the journal entry
  void updateJournal(Journal journal) async {
    await _firestore
        .collection(_collectionJournals)
        .document(journal.documentID)
        .updateData({
      'date': journal.date,
      'mood': journal.mood,
      'note': journal.note,
    }).catchError((error) => print('Error updating: $error'));
  }

  // deleting a journal entry
  void deleteJournal(Journal journal) async {
    await _firestore
        .collection(_collectionJournals)
        .document(journal.documentID)
        .delete()
        .catchError((error) => print('Error deleting: $error'));
  }

  @override
  Future<Journal> getJournal(String documentID) {
    // TODO: implement getJournal
    throw UnimplementedError();
  }

  @override
  void updateJournalWithTransac(String documeurnal) {
    // TODO: implement updateJournalWithTransaction
  }

  @override
  void updateJournalWithTransaction(Journal journal) {
    // TODO: implement updateJournalWithTransaction
  }
}
