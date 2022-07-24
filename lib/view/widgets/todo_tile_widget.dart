import 'package:flutter/material.dart';

import '../../models/todo.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    Key? key,
    required this.todo,
    required this.onDelete,
    required this.onChanged,
  }) : super(key: key);

  final ToDo todo;
  final VoidCallback onDelete;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Checkbox(
            value: todo.isDone,
            onChanged: onChanged,
          ),
          Text(
            todo.title,
            style: TextStyle(
              fontSize: 16,
              color: todo.isDone ? Colors.green : Colors.red,
              decoration: todo.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
