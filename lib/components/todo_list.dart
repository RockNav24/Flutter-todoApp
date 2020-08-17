import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class TodoList extends StatefulWidget {
  static List<Task> tasks = [
    Task(title: 'Play cricket'),
    Task(title: 'Buy milk'),
    Task(title: 'Call san'),
  ];
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: TodoList.tasks.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(
            TodoList.tasks[index].title,
            style: TextStyle(
                decoration: TodoList.tasks[index].isChecked
                    ? TextDecoration.lineThrough
                    : null),
          ),
          value: TodoList.tasks[index].isChecked,
          onChanged: (bool value) {
            setState(() {
              TodoList.tasks[index].toggleCheck();
            });
          },
        );
      },
    );
  }
}
