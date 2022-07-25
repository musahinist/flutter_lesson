import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/view/screens/todo_detail_page.dart';

import '../../models/to_do.dart';

import '../widgets/todo_tile_widget.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  //TODO: remove this list
  List<ToDo> todoList = [];
  final controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //TODO fetch data from shared preferences check if data null
    //TODO convert strong to JSon and Data  Class
    //TODO set data to todoList
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
                  .push(
                    MaterialPageRoute(
                      builder: (context) =>
                          TodoDetailPage(todo: todoList[index]),
                    ),
                  )
                  .then((value) {});
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
      final prefs = await SharedPreferences.getInstance();
      ToDo todo = ToDo(title: controller.text, isDone: false);
      // todo saved to local db
      prefs.setString('todo', todo.toJson().toString());
//TODO: remove method
      todoList.add(todo);
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
