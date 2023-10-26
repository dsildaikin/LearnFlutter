import 'package:flutter/material.dart';
import 'package:todo_app_sqlite/screens/detail_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ежедневник',
      home: DetailScreen(),
    );
  }
}

// class TodoPage extends StatefulWidget {
//   @override
//   _TodoPageState createState() => _TodoPageState();
// }

// class _TodoPageState extends State<TodoPage> {
//   final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
//   final _todoNameController = TextEditingController();
//
//   late Future<List<Todo>> _todosList;
//   late String _todoName;
//   bool isUpdate = false;
//   int? todoIdForUpdate;
//
//   @override
//   void initState() {
//     super.initState();
//     updateTodoList();
//   }
//
//   updateTodoList() {
//     setState(() {
//       _todosList = DBProvider.db.getTodos();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('SQLite CRUD Demo'),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: <Widget>[
//           Form(
//             key: _formStateKey,
//             autovalidateMode: AutovalidateMode.always,
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value == null) {
//                         return 'Please Enter Todo Name';
//                       }
//                       if (value.trim() == "") {
//                         return "Only Space is Not Valid!!!";
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       _todoName = value!;
//                     },
//                     controller: _todoNameController,
//                     decoration: const InputDecoration(
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(
//                             color: Colors.greenAccent,
//                             width: 2,
//                             style: BorderStyle.solid),
//                       ),
//                       labelText: "Todo Name",
//                       icon: Icon(
//                         Icons.people,
//                         color: Colors.black,
//                       ),
//                       fillColor: Colors.white,
//                       labelStyle: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   textStyle: const TextStyle(color: Colors.white),
//                 ),
//                 child: Text(
//                   (isUpdate ? 'UPDATE' : 'ADD'),
//                 ),
//                 onPressed: () {
//                   if (isUpdate) {
//                     if (_formStateKey.currentState!.validate()) {
//                       _formStateKey.currentState!.save();
//                       DBProvider.db
//                           .updateTodo(Todo(todoIdForUpdate!, _todoName))
//                           .then((data) {
//                         setState(() {
//                           isUpdate = false;
//                         });
//                       });
//                     }
//                   } else {
//                     if (_formStateKey.currentState!.validate()) {
//                       _formStateKey.currentState!.save();
//                       DBProvider.db.insertTodo(Todo(null, _todoName));
//                     }
//                   }
//                   _todoNameController.text = '';
//                   updateTodoList();
//                 },
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(10),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   textStyle: const TextStyle(color: Colors.white),
//                 ),
//                 child: Text(
//                   (isUpdate ? 'CANCEL UPDATE' : 'CLEAR'),
//                 ),
//                 onPressed: () {
//                   _todoNameController.text = '';
//                   setState(() {
//                     isUpdate = false;
//                     todoIdForUpdate = null; // null;
//                   });
//                 },
//               ),
//             ],
//           ),
//           const Divider(
//             height: 5.0,
//           ),
//           Expanded(
//             child: FutureBuilder(
//               future: _todosList,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return generateList(snapshot.data as List<Todo>);
//                 }
//                 if (snapshot.data == null ||
//                     (snapshot.data as List<Todo>).isEmpty) {
//                   return const Text('No Data Found');
//                 }
//                 return const CircularProgressIndicator();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   SingleChildScrollView generateList(List<Todo> todos) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: DataTable(
//           columns: const [
//             DataColumn(
//               label: Text('NAME'),
//             ),
//             DataColumn(
//               label: Text('DELETE'),
//             ),
//           ],
//           rows: todos
//               .map(
//                 (todo) => DataRow(cells: [
//                   DataCell(Text(todo.name), onTap: () {
//                     setState(() {
//                       isUpdate = true;
//                       todoIdForUpdate = todo.id;
//                     });
//                     _todoNameController.text = todo.name;
//                   }),
//                   DataCell(
//                     IconButton(
//                       icon: const Icon(Icons.delete),
//                       onPressed: () {
//                         DBProvider.db.deleteTodo(todo.id);
//                         updateTodoList();
//                       },
//                     ),
//                   ),
//                 ]),
//               )
//               .toList(),
//         ),
//       ),
//     );
//   }
// }
