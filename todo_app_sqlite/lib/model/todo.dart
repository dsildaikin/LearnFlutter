class Todo {
  int? id;
  late String name;
  late String dateTime;
  late String importance;
  late String note;
  late bool completed;

  Todo(
    this.id,
    this.name,
    this.dateTime,
    this.importance,
    this.note,
    this.completed,
  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['dateTime'] = dateTime;
    map['importance'] = importance;
    map['note'] = note;
    map['completed'] = completed;
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    dateTime = map['dateTime'];
    importance = map['importance'];
    note = map['note'];
    completed = map['completed'];
  }
}
