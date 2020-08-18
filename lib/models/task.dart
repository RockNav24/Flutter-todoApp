import 'package:todo_app/sqflite_database.dart';
import 'package:flutter/material.dart';

class Task extends ChangeNotifier {
  int id;
  String title;
  bool isChecked;

  Task({this.id, this.title, this.isChecked = false});

  void toggleCheck() {
    isChecked = !isChecked;
    notifyListeners();
  }

  // Convert Task into a map.
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseClass.TITLE: title,
      DatabaseClass.IS_CHECKED: isChecked ? 1 : 0,
    };

    if (id != null) {
      map[DatabaseClass.ID] = id;
    }
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseClass.ID];
    title = map[DatabaseClass.TITLE];
    isChecked = map[DatabaseClass.IS_CHECKED] == 1;
    notifyListeners();
  }

  @override
  String toString() {
    return 'id: $id, title: $title, isCheck: $isChecked';
  }
}
