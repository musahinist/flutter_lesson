import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage({Key? key, required this.todo}) : super(key: key);
  final ToDo todo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // send  data from checkbox to previouse page
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Text(todo.title),
          //TODO:1 add checkbox
        ],
      ),
    );
  }
}
