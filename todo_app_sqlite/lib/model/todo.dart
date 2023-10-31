class Todo {
  int? id;
  late String name;

  // late String time;
  // late String date;
  // late String importanceDegree;
  // late String note;
  // late String completed;

  Todo(
    this.id,
    this.name,
    // this.time,
    // this.date,
    // this.importanceDegree,
    // this.note,
    // this.completed,
  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    // map['time'] = time;
    // map['date'] = date;
    // map['importanceDegree'] = importanceDegree;
    // map['note'] = note;
    // map['completed'] = completed;
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    // time = map['time'];
    // date = map['date'];
    // importanceDegree = map['importanceDegree'];
    // note = map['note'];
    // completed = map['completed'];
  }
}
