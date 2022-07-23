import 'package:flutter/material.dart';

import '../widgets/todo_tile_widget.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todoList = [
    'sdfd',
    'ekemek al',
    'çöpleri çıkar',
    'flutter calış'
  ];
  //TODO1: add text editing controller for text form field
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        //TODO:2 add textformfield widget for title
      ),
      body: ListView(
          children: List.generate(
        todoList.length,
        (index) => TodoTile(
          title: todoList[index],
          onDelete: () {
            todoList.removeAt(index);
            setState(() {});
          },
        ),
      )
          // [
          //   for (int i = 0; i < todoList.length; i++) TodoTile(),
          // ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO3: create vew todo tile with new value
          todoList.add("todo");
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
