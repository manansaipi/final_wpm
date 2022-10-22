import 'package:final_wpm/db/db_helper.dart';
import 'package:get/get.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTask();
    getTask2();
    super.onReady();
  }

  var taskList = <Task>[].obs;
  var savedTaskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void getTask() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    // taskList.sort((a, b) => a.startTime!.compareTo(b.startTime));
    print("getTask");

    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void getTask2() async {
    List<Map<String, dynamic>> tasks = await DBHelper.findSavedTask();
    // taskList.sort((a, b) => a.startTime!.compareTo(b.startTime));
    print("getTask2");

    savedTaskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTask();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.updateCompleted(id);
    getTask();
  }

  void markTaskUnCompleted(int id) async {
    await DBHelper.updateUncopleted(id);
    getTask();
  }
}
