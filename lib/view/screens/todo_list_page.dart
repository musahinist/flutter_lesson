import 'package:flutter/material.dart';
import 'package:todo_list/view/screens/todo_detail_page.dart';

import '../../models/todo.dart';
import '../widgets/todo_tile_widget.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<ToDo> todoList = [
    ToDo(title: 'todo1', isDone: true),
    ToDo(title: 'todo2'),
  ];
  final controller = TextEditingController();

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
                  .push(
                MaterialPageRoute(
                  builder: (context) => TodoDetailPage(todo: todoList[index]),
                ),
              )
                  .then((value) {
                //toggle method
                // todoList[index].isDone = !todoList[index].isDone;
                //TODO: set data to isDone from value
                setState(() {});
              });
            },
            child: TodoTile(
              todo: todoList[index],
              onDelete: () {
                todoList.removeAt(index);
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

      todoList.add(ToDo(title: controller.text));
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
