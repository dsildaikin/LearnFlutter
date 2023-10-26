import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
              decoration: const InputDecoration(
                labelText: 'Название',
                hintText: 'Введите название',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Дата',
                hintText: 'Введите дату',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
