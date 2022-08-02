import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/view/screens/todo_detail_page.dart';

import '../../models/to_do.dart';

import '../widgets/todo_tile_widget.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);
  static const routeName = "home";
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<ToDo> todoList = [];
  final controller = TextEditingController();
  final String todoKey = 'todos';
  @override
  void initState() {
    super.initState();
    getTodosFromShared();
  }

  getTodosFromShared() async {
    final prefs = await SharedPreferences.getInstance();
    String? todos = prefs.getString(todoKey);
    if (todos != null) {
      todoList =
          jsonDecode(todos).map<ToDo>((el) => ToDo.fromJson(el)).toList();
    }
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: TextFormField(
          controller: controller,
        ),
      ),
      body: ListView(
        children: List.generate(
          todoList.length,
          (index) => InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(
                    TodoDetailPage.routeName,
                    arguments: todoList[index],
                  )
                  .then((value) {});
            },
            child: TodoTile(
              todo: todoList[index],
              onDelete: () async {
                todoList.removeAt(index);
                final prefs = await SharedPreferences.getInstance();
                prefs.setString(todoKey, jsonEncode(todoList));
                setState(() {});
              },
              onChanged: (value) {
                todoList[index].isDone = value!;
                setState(() {});
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: loading ? null : addTodo,
        backgroundColor: Colors.blue,
        child: loading ? CircularProgressIndicator() : const Icon(Icons.add),
      ),
    );
  }

  void addTodo() async {
    if (controller.text.isNotEmpty) {
      loading = true;
      setState(() {});
      await Future.delayed(Duration(seconds: 2));
      loading = false;
      final prefs = await SharedPreferences.getInstance();
      ToDo todo = ToDo(title: controller.text, isDone: false);
      todoList.add(todo);

      prefs.setString(todoKey, jsonEncode(todoList));
      controller.clear();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'bu alan boş olamaz',
          ),
        ),
      );
    }
  }
}
