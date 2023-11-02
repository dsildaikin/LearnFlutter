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
  bool isUpdate = false;

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
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(isUpdate: isUpdate),
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
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text('Название: ${todo.name}'),
                    const SizedBox(height: 5),
                    Text('Сделать до: ${todo.time} ${todo.date}'),
                    const SizedBox(height: 5),
                    Text('Степень важности: ${todo.importanceDegree}'),
                    const SizedBox(height: 5),
                    Text('Статус: ${todo.completed}'),
                    const SizedBox(height: 20),
                    Text('Примечание: ${todo.note}'),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: () {
                        DBProvider.db.deleteTodo(todo.id);
                        updateTodoList();
                      }),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(isUpdate: true, todo: todo)))
                          .then((value) {
                        setState(() {
                          _todosList = DBProvider.db.getTodos();
                        });
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
