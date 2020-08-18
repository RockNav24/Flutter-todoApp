import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:todo_app/models/task.dart';

// Get the correct local path
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

// Create a referance to the file location
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/todoData.txt');
}

// Write data to the file
Future<File> writeToFile(Task task) async {
  final file = await _localFile;

  // Write data
  return file.writeAsString(task.title);
}
