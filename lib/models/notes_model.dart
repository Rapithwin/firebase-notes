import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  final String? title;
  final String? content;
  final DateTime? dateModified;

  NotesModel({
    this.title,
    this.content,
    this.dateModified,
  });

  factory NotesModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return NotesModel(
      title: data?["title"],
      content: data?["content"],
      dateModified: data?["date"],
    );
  }

  Map<String, dynamic> toFirestore() => {
    if (title != null) "title": title,
    if (content != null) "content": content,
    if (dateModified != null) "date": dateModified,
  };
}
