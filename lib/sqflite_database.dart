import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:todo_app/models/task.dart';

class DatabaseClass {
  static const String TABLE_NAME = 'tasks';
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String IS_CHECKED = 'isChecked';

  Database _database;

  DatabaseClass() {
    database;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await createDatabase();
    }
    print('db created');
    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'task_db.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print('Creating database');
        return await database.execute(
          "CREATE TABLE $TABLE_NAME ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TITLE TEXT,$IS_CHECKED INTEGER)",
        );
      },
    );
  }

  // Add to task database
  Future<Task> insertTask(Task task) async {
    final Database db = await database;
    task.id = await db.insert(TABLE_NAME, task.toMap());
    print('added to the db');
    return task;
  }

  // Retrive all the tasks from taks table
  Future<List<Task>> getTasks() async {
    final Database db = await database;
    var tasks = await db.query(
      TABLE_NAME,
      columns: [ID, TITLE, IS_CHECKED],
    );
    List<Task> taskList = [];
    tasks.forEach((element) {
      Task task = Task.fromMap(element);
      taskList.add(task);
    });
    print('get data from db');
    return taskList;
  }

  Future<void> updateTask(Task task) async {
    final db = await database;

    await db.update(
      TABLE_NAME,
      task.toMap(),
      where: '$ID = ?',
      whereArgs: [task.id],
    );
    print('updated');
  }

  Future<void> deleteTask(Task task) async {
    final db = await database;

    await db.delete(
      TABLE_NAME,
      where: '$ID = ?',
      whereArgs: [task.id],
    );
    print('delete');
  }
}
