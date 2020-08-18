import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/sqflite_database.dart';

class TaskData extends ChangeNotifier {
  DatabaseClass db = DatabaseClass();
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addNewTask(Task task) async {
    this._tasks.add(await db.insertTask(task));
    getAllTasks();
    notifyListeners();
  }

  void deleteTask(Task task) async {
    await db.deleteTask(task);
    getAllTasks();
    notifyListeners();
  }

  void updateTask(Task task) async {
    task.toggleCheck();
    await db.updateTask(task);
    notifyListeners();
  }

  Future<void> getAllTasks() async {
    this._tasks = await db.getTasks();
    notifyListeners();
  }
}
