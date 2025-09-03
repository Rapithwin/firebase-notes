class NotesModel {
  final String title;
  final String content;
  final DateTime dateModified;

  NotesModel({
    required this.title,
    required this.content,
    required this.dateModified,
  });

  factory NotesModel.fromMap(Map<String, dynamic> note) => NotesModel(
    title: note["title"],
    content: note["content"],
    dateModified: note["date"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "content": content,
    "date": dateModified,
  };
}
