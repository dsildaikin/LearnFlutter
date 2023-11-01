import 'package:flutter/material.dart';
import 'package:todo_app_sqlite/db/database.dart';
import 'package:todo_app_sqlite/model/todo.dart';
import 'package:todo_app_sqlite/screens/detail_screen.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  late Future<List<Todo>> _todosList;

  @override
  void initState() {
    super.initState();
    updateTodoList();
  }

  updateTodoList() {
    setState(() {
      _todosList = DBProvider.db.getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список дел'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(),
            ),
          )
              .then((value) {
            setState(() {
              _todosList = DBProvider.db.getTodos();
            });
          });
        },
      ),
      body: FutureBuilder(
        future: _todosList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return generateList(snapshot.data as List<Todo>);
          }
          if (snapshot.data == null || (snapshot.data as List<Todo>).isEmpty) {
            return const Text('No Data Found');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  generateList(List<Todo> todos) {
    return ListView(
      children: todos.map((todo) {
        return Card(
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Название: ${todo.name}'),
                Text('Сделать до: ${todo.time} ${todo.date}'),
                Text('Степень важности: ${todo.importanceDegree}'),
              ],
            ),
            subtitle: Text('Примечание: ${todo.note}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                DBProvider.db.deleteTodo(todo.id);
                updateTodoList();
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
