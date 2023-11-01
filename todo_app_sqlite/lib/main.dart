import 'package:flutter/material.dart';
import 'package:todo_app_sqlite/screens/todos_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),
      title: 'Ежедневник',
      home: TodosScreen(),
    );
  }
}
