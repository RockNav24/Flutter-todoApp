import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todo_app/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(title: 'Add a new Task'),
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addNewTask(Task newTask) {
    this._tasks.add(newTask);
    notifyListeners();
  }

  void deleteTask(int index) {
    this._tasks.removeAt(index);
    notifyListeners();
  }

  void updateTask(int index) {
    this._tasks[index].toggleCheck();
    notifyListeners();
  }
}
