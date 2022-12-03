import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "tasks";
  static const String _sortTime = "sortTime";

  static Future<void> initDb() async {
    if (_db != null) {
      // "DROP TABLE $_tableName";
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("creating a new one");
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title STRING, note TEXT, date STRING,  "
          "startTime STRING, endTime STRING, $_sortTime INTEGER,"
          "repeat STRING, "
          "color INTEGER, mapCoor STRING,"
          "isCompleted INTEGER, savedTask INTEGER, taskCreated STRING) ",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("insert function called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static update(
    Task task,
    int id,
  ) async {
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET title = ?,note = ?,date = ?,startTime = ?,endTime = ?,repeat = ?,color = ?,mapCoor = ? ,savedTask = ?
    WHERE id =?
''', [
      task.title,
      task.note,
      task.date,
      task.startTime,
      task.endTime,
      task.repeat,
      task.color,
      task.mapCoor,
      task.savedTask,
      id
    ]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _db!.query(_tableName, orderBy: _sortTime);
  }

  static Future<List<Map<String, dynamic>>> findSavedTask() async {
    return await _db!.query(_tableName, where: 'savedTask=?', whereArgs: [1]);
  }

  static delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static deleteAll(Task task) async {
    return await _db!.delete(_tableName,
        where: 'title=? and taskCreated=?',
        whereArgs: [task.title, task.taskCreated]);
  }

  static autoDelete(Task task, String date) async {
    return await _db!.delete(_tableName, where: 'date=?', whereArgs: [date]);
  }

  static updateCompleted(int id) async {
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id =?
''', [1, id]);
  }

  static updateUncopleted(int id) async {
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id =?
''', [0, id]);
  }
}
