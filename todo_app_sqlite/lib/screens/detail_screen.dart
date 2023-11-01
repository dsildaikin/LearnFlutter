import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool isUpdate = false;

  final _formStateKey = GlobalKey<FormState>();

  final _todoNameController = TextEditingController(text: 'Сходить в магазин');
  final _todoTimeController = TextEditingController(text: '12:10');
  final _todoDateController = TextEditingController(text: '03.11.23');
  final _todoImportanceDegreeController =
      TextEditingController(text: 'Не срочно');
  final _todoNoteController =
      TextEditingController(text: 'По пути прогуляться в парке');
  final _todoCompletedController = TextEditingController(text: 'Выполняется');

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
              decoration: InputDecoration(
                labelText: 'Название',
                hintText: 'Введите название',
                prefixIcon: const Icon(Icons.cases_rounded),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _todoNameController.clear();
                  },
                  child: const Icon(Icons.delete_outline, color: Colors.red),
                ),
                border: const OutlineInputBorder(),
              ),
              inputFormatters: [LengthLimitingTextInputFormatter(30)],
              onSaved: (value) => _todoName = value!,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле ввода не должно быть пустым!';
                }
                if (value.trim() == "") {
                  return "Поле ввода не должно содержать только пробел!";
                }
                return null;
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
              keyboardType: TextInputType.datetime,
              inputFormatters: [LengthLimitingTextInputFormatter(5)],
              onSaved: (value) => _todoTime = value!,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле ввода не должно быть пустым!';
                }
                if (value.trim() == "") {
                  return "Поле ввода не должно содержать только пробел!";
                }
                return null;
              },
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
              keyboardType: TextInputType.datetime,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              onSaved: (value) => _todoDate = value!,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле ввода не должно быть пустым!';
                }
                if (value.trim() == "") {
                  return "Поле ввода не должно содержать только пробел!";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _todoImportanceDegreeController,
              focusNode: _todoImportanceDegreeFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(
                  context,
                  _todoImportanceDegreeFocus,
                  _todoCompletedFocus,
                );
              },
              decoration: const InputDecoration(
                labelText: 'Степень важности',
                hintText: 'Введите степень важности',
                prefixIcon: Icon(Icons.label_important),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _todoImportanceDegree = value!,
              inputFormatters: [LengthLimitingTextInputFormatter(11)],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _todoNoteController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Примечание',
                hintText: 'Введите примечание',
                prefixIcon: Icon(Icons.description),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _todoNoteController.clear();
                  },
                  child: const Icon(Icons.delete_outline, color: Colors.red),
                ),
                border: const OutlineInputBorder(),
              ),
              onSaved: (value) => _todoNote = value!,
              inputFormatters: [LengthLimitingTextInputFormatter(50)],
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
              onSaved: (value) => _todoCompleted = value!,
              inputFormatters: [LengthLimitingTextInputFormatter(11)],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле ввода не должно быть пустым!';
                }
                if (value.trim() == "") {
                  return "Поле ввода не должно содержать только пробел!";
                }
                return null;
              },
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
        _todoNameController.text = '';
        _todoTimeController.text = '';
        _todoDateController.text = '';
        _todoImportanceDegreeController.text = '';
        _todoNoteController.text = '';
        _todoCompletedController.text = '';

        Navigator.pop(context);
      }
    }
  }
}
