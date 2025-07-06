class TodoItem {
  String title;
  bool done;
  DateTime? date;
  TodoItem({required this.title, this.done = false, this.date});

  Map<String, dynamic> toJson() => {
    'title': title,
    'done': done,
    'date': date?.toIso8601String(),
  };
  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      TodoItem(
        title: json['title'],
        done: json['done'],
        date: json['date'] != null ? DateTime.parse(json['date']) : null,
      );
}