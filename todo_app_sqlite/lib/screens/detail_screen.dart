import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_sqlite/db/database.dart';
import 'package:todo_app_sqlite/model/todo.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({super.key, required this.isUpdate, this.todo});

  Todo? todo;
  bool isUpdate;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String _todoName;
  late String _todoTime;
  late String _todoDate;
  late String _todoImportanceDegree;
  late String _todoNote;
  late String _todoCompleted;

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

  void _textFieldsValue() {
    _todoNameController.text =
        widget.isUpdate ? widget.todo!.name : 'Сходить в магазин';
    _todoTimeController.text = widget.isUpdate ? widget.todo!.time : '12:30';
    _todoDateController.text = widget.isUpdate ? widget.todo!.date : '03.11.23';
    _todoImportanceDegreeController.text =
        widget.isUpdate ? widget.todo!.importanceDegree : 'Важно';
    _todoNoteController.text =
        widget.isUpdate ? widget.todo!.note : 'По пути прогуляться по парку';
    _todoCompletedController.text =
        widget.isUpdate ? widget.todo!.completed : 'Выполняется';
  }

  @override
  Widget build(BuildContext context) {
    _textFieldsValue();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdate ? 'Изменение дела' : 'Добавление дела'),
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
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        _todoNameController.clear();
                      }),
                  border: const OutlineInputBorder()),
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
              decoration: InputDecoration(
                labelText: 'Время',
                hintText: 'Введите время',
                prefixIcon: const Icon(Icons.access_time_outlined),
                suffixIcon: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      _todoTimeController.clear();
                    }),
                border: const OutlineInputBorder(),
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
              decoration: InputDecoration(
                labelText: 'Дата',
                hintText: 'Введите дату',
                prefixIcon: const Icon(Icons.calendar_month),
                suffixIcon: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      _todoDateController.clear();
                    }),
                border: const OutlineInputBorder(),
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
              decoration: InputDecoration(
                labelText: 'Степень важности',
                hintText: 'Введите степень важности',
                prefixIcon: const Icon(Icons.label_important),
                suffixIcon: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      _todoImportanceDegreeController.clear();
                    }),
                border: const OutlineInputBorder(),
              ),
              onSaved: (value) => _todoImportanceDegree = value!,
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
            const SizedBox(height: 10),
            TextFormField(
              controller: _todoNoteController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Примечание',
                hintText: 'Введите примечание',
                prefixIcon: const Icon(Icons.description),
                suffixIcon: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      _todoNoteController.clear();
                    }),
                border: const OutlineInputBorder(),
              ),
              onSaved: (value) => _todoNote = value!,
              inputFormatters: [LengthLimitingTextInputFormatter(50)],
            ),
            const SizedBox(height: 10),
            TextFormField(
              focusNode: _todoCompletedFocus,
              controller: _todoCompletedController,
              decoration: InputDecoration(
                labelText: 'Статус',
                hintText: 'Введите статус дела',
                prefixIcon: const Icon(Icons.done),
                suffixIcon: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      _todoCompletedController.clear();
                    }),
                border: const OutlineInputBorder(),
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
                  child: Text(widget.isUpdate ? 'Изменить' : 'Добавить'),
                ),
                ElevatedButton(
                  onPressed: _clearTodo,
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
    if (widget.isUpdate) {
      if (_formStateKey.currentState!.validate()) {
        _formStateKey.currentState!.save();
        DBProvider.db.updateTodo(
          Todo(
            widget.todo!.id,
            _todoName,
            _todoTime,
            _todoDate,
            _todoImportanceDegree,
            _todoNote,
            _todoCompleted,
          ),
        );
        Navigator.pop(context);
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

  void _clearTodo() {
    _todoNameController.text = '';
    _todoTimeController.text = '';
    _todoDateController.text = '';
    _todoImportanceDegreeController.text = '';
    _todoNoteController.text = '';
    _todoCompletedController.text = '';
  }
}
