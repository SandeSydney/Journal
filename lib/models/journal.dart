class Journal {
  // member variable
  String documentID;
  String date;
  String mood;
  String note;
  String uid;

  // reference using syntactic sugar
  Journal({this.documentID, this.date, this.mood, this.note, this.uid});

  // convert and map journal entry to Cloud Firestore database document record
  factory Journal.fromDoc(dynamic doc) => Journal(
      documentID: doc.documentId,
      date: doc["date"],
      mood: doc["mood"],
      note: doc["note"],
      uid: doc["uid"]);
}
