import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_sqlite/model/todo.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static late Database _database;

  String todosTable = 'Todos';
  String columnId = 'id';
  String columnName = 'name';
  String columnTime = 'time';
  String columnDate = 'date';
  String columnImportanceDegree = 'importanceDegree';
  String columnNote = 'note';
  String columnCompleted = 'completed';

  Future<Database> get database async {
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
      '$columnTime TEXT, '
      '$columnDate TEXT, '
      '$columnImportanceDegree TEXT, '
      '$columnNote TEXT, '
      '$columnCompleted TEXT)',
    );
  }

  // READ
  Future<List<Todo>> getTodos() async {
    Database db = await database;
    final List<Map<String, dynamic>> todosMapList = await db.query(todosTable);
    final List<Todo> todosList = [];
    for (var todoMap in todosMapList) {
      todosList.add(Todo.fromMap(todoMap));
    }
    return todosList;
  }

  Future<List<Todo>> searchTodos(String keyword) async {
    Database db = await database;
    List<Map<String, dynamic>> todosMapList = await db.query(
      todosTable,
      where: '$columnName LIKE ?',
      whereArgs: ['%$keyword%'],
    );
    final List<Todo> todosList = [];
    for (var todoMap in todosMapList) {
      todosList.add(Todo.fromMap(todoMap));
    }
    return todosList;
  }

  // INSERT
  Future<Todo> insertTodo(Todo todo) async {
    Database db = await database;
    todo.id = await db.insert(todosTable, todo.toMap());
    return todo;
  }

  // UPDATE
  Future<int> updateTodo(Todo todo) async {
    Database db = await database;
    return await db.update(
      todosTable,
      todo.toMap(),
      where: '$columnId = ?',
      whereArgs: [todo.id],
    );
  }

  // DELETE
  Future<int> deleteTodo(int? id) async {
    Database db = await database;
    return await db.delete(
      todosTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
