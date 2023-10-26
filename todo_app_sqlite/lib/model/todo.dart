class Todo {
  int? id;
  late String name;
  // late String date;
  // late String time;
  // late String importance;
  // late String note;
  // late String completed;

  Todo(
    this.id,
    this.name,
    // this.date,
    // this.time,
    // this.importance,
    // this.note,
    // this.completed,
  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    // map['date'] = date;
    // map['time'] = time;
    // map['importance'] = importance;
    // map['note'] = note;
    // map['completed'] = completed;
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    // date = map['date'];
    // time = map['time'];
    // importance = map['importance'];
    // note = map['note'];
    // completed = map['completed'];
  }
}
