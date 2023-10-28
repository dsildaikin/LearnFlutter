import 'package:flutter/material.dart';
import 'package:todo_app_sqlite/db/database.dart';
import 'package:todo_app_sqlite/model/todo.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int? todoIdForUpdate;

  late String _todoName;
  late String _todoTime;
  late String _todoDate;
  late String _todoImportanceDegree;
  late String _todoNote;
  late String _todoCompleted;

  late Future<List<Todo>> _todosList;

  bool isUpdate = false;

  final _importanceDegrees = ['Очень важно', 'Важно', 'Не горит'];
  String _selectedImportanceDegree = 'Важно';

  final _formStateKey = GlobalKey<FormState>();

  final _todoNameController = TextEditingController();
  final _todoTimeController = TextEditingController();
  final _todoDateController = TextEditingController();
  final _todoImportanceDegreeController = TextEditingController();
  final _todoNoteController = TextEditingController();
  final _todoCompletedController = TextEditingController();

  final _todoNameFocus = FocusNode();
  final _todoTimeFocus = FocusNode();
  final _todoDateFocus = FocusNode();
  final _todoImportanceDegreeFocus = FocusNode();
  final _todoCompletedFocus = FocusNode();

  @override
  void dispose() {
    _todoNameController.dispose();
    _todoTimeController.dispose();
    _todoDateController.dispose();
    _todoImportanceDegreeController.dispose();
    _todoNoteController.dispose();
    _todoCompletedController.dispose();

    _todoNameFocus.dispose();
    _todoTimeFocus.dispose();
    _todoDateFocus.dispose();
    _todoImportanceDegreeFocus.dispose();
    _todoCompletedFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактирование дела'),
        centerTitle: true,
      ),
      body: Form(
        key: _formStateKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _todoNameController,
              focusNode: _todoNameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _todoNameFocus, _todoTimeFocus);
              },
              decoration: const InputDecoration(
                labelText: 'Название',
                hintText: 'Введите название',
                prefixIcon: Icon(Icons.cases_rounded),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле ввода не должно быть пустым!';
                }
                if (value.trim() == "") {
                  return "Поле ввода не должно содержать только пробел!";
                }
                return null;
              },
              onSaved: (value) {
                _todoName = value!;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _todoTimeController,
              focusNode: _todoTimeFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _todoTimeFocus, _todoDateFocus);
              },
              decoration: const InputDecoration(
                labelText: 'Время',
                hintText: 'Введите время',
                prefixIcon: Icon(Icons.access_time_outlined),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _todoDateController,
              focusNode: _todoDateFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(
                  context,
                  _todoDateFocus,
                  _todoImportanceDegreeFocus,
                );
              },
              decoration: const InputDecoration(
                labelText: 'Дата',
                hintText: 'Введите дату',
                prefixIcon: Icon(Icons.calendar_month),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              focusNode: _todoImportanceDegreeFocus,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.label_important),
                labelText: 'Степень важности',
              ),
              items: _importanceDegrees.map((importanceDegree) {
                return DropdownMenuItem(
                  onTap: () {
                    _fieldFocusChange(
                      context,
                      _todoImportanceDegreeFocus,
                      _todoCompletedFocus,
                    );
                  },
                  value: importanceDegree,
                  child: Text(importanceDegree),
                );
              }).toList(),
              onChanged: (importanceDegree) {
                setState(() {
                  _selectedImportanceDegree = importanceDegree as String;
                });
              },
              value: _selectedImportanceDegree,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _todoNoteController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Примечание',
                hintText: 'Введите примечание',
                prefixIcon: Icon(Icons.description),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              focusNode: _todoCompletedFocus,
              controller: _todoCompletedController,
              decoration: const InputDecoration(
                labelText: 'Статус',
                hintText: 'Введите статус дела',
                prefixIcon: Icon(Icons.done),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addOrUpdateTodo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Добавить'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Очистить'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addOrUpdateTodo() {
    if (isUpdate) {
      if (_formStateKey.currentState!.validate()) {
        _formStateKey.currentState!.save();
        DBProvider.db
            .updateTodo(
          Todo(
            todoIdForUpdate!,
            _todoName,
            _todoTime,
            _todoDate,
            _todoImportanceDegree,
            _todoNote,
            _todoCompleted,
          ),
        )
            .then((data) {
          setState(() {
            isUpdate = false;
          });
        });
      }
    } else {
      if (_formStateKey.currentState!.validate()) {
        _formStateKey.currentState!.save();
        DBProvider.db.insertTodo(
          Todo(
            null,
            _todoName,
            _todoTime,
            _todoDate,
            _todoImportanceDegree,
            _todoNote,
            _todoCompleted,
          ),
        );
      }
    }
    _todoNameController.text = '';
    _todoTimeController.text = '';
    _todoDateController.text = '';
    _todoImportanceDegreeController.text = '';
    _todoNoteController.text = '';
    _todoCompletedController.text = '';

    updateTodoList();
  }

  updateTodoList() {
    setState(() {
      _todosList = DBProvider.db.getTodos();
    });
  }
}
