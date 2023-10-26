import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  final _importanceDegreeController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    _dateController.dispose();
    _importanceDegreeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детальная страница'),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _nameController,
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
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _timeController,
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
              controller: _dateController,
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
            TextFormField(
              controller: _importanceDegreeController,
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
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _noteController,
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
          ],
        ),
      ),
    );
  }
}
