import 'package:flutter/material.dart';
import 'package:todo_list/view/screens/todo_detail_page.dart';

import 'view/screens/todo_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: TodoList.routeName,
      routes: {
        TodoList.routeName: (context) => const TodoList(),
        TodoDetailPage.routeName: (context) => const TodoDetailPage()
      },
    );
  }
}
