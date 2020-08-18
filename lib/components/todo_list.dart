import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/task_data.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.watch<TaskData>().tasks.length,
      itemBuilder: (context, index) {
        Task task = context.watch<TaskData>().tasks[index];
        return Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            context.read<TaskData>().deleteTask(index);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("'${task.title}' deleted"),
              ),
            );
          },
          key: ObjectKey(task.title),
          background: Container(
            color: Colors.red[600],
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
          ),
          child: ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                  decoration:
                      task.isChecked ? TextDecoration.lineThrough : null),
            ),
            trailing: Checkbox(
              value: task.isChecked,
              onChanged: (bool value) {
                context.read<TaskData>().updateTask(index);
              },
            ),
          ),
        );
      },
    );
  }
}
