import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_app_sqlite/model/todo.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static late Database _database;

  String todosTable = 'Todos';
  String columnId = 'id';
  String columnName = 'name';
  String columnDate = 'date';
  String columnTime = 'time';
  String columnImportance = 'importance';
  String columnNote = 'note';
  String columnCompleted = 'completed';

  Future<Database> get database async {
    //if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}Todo.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $todosTable('
      '$columnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$columnName TEXT, '
      '$columnDate TEXT, '
      '$columnTime TEXT, '
      '$columnImportance TEXT, '
      '$columnCompleted TEXT)',
    );
  }

  // READ
  Future<List<Todo>> getStudents() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> studentsMapList =
        await db.query(todosTable);
    final List<Todo> studentsList = [];
    studentsMapList.forEach((studentMap) {
      studentsList.add(Todo.fromMap(studentMap));
    });

    return studentsList;
  }
}
