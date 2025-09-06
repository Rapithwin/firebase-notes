import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  final String? id;
  final String? title;
  final String? content;
  final DateTime? dateModified;
  bool isSelected;

  NotesModel({
    this.id,
    this.title,
    this.content,
    this.dateModified,
    this.isSelected = false,
  });

  factory NotesModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return NotesModel(
      id: snapshot.id,
      title: data?["title"],
      content: data?["content"],
      dateModified: data?["date"].toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    if (title != null) "title": title,
    if (content != null) "content": content,
    if (dateModified != null) "date": dateModified,
  };
}
