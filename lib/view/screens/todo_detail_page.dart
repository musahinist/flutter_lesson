import 'package:flutter/material.dart';

import '../../models/to_do.dart';

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage({Key? key}) : super(key: key);
  static const routeName = "detail";
  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as ToDo;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Text(todo.title!),
        ],
      ),
    );
  }
}
