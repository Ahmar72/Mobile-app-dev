class Task {
  String? id;
  String title;

  Task({this.id, required this.title});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['_id'],
    title: json['title'],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
  };
}
