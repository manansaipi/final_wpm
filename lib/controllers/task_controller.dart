// ignore_for_file: unused_local_variable

import 'package:final_wpm/db/db_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  @override
  // String date = (DateFormat.yMd()
  //     .format(DateTime.parse(DateTime.now().toString().split(" ")[0])));
  String date = "";
  void onReady() {
    String date = (DateFormat.yMd()
        .format(DateTime.parse(DateTime.now().toString().split(" ")[0])));
    getTask();
    getTask2(date);

    super.onReady();
  }

  var taskList = <Task>[].obs;
  var taskListByDate = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    getTask2(date);

    return await DBHelper.insert(task);
  }

  Future<int?> updateData({Task? task, int? id}) async {
    getTask2(date);
    return await DBHelper.update(task!, id!);
  }

  Future<int?> updateAllData({Task? task, String? title}) async {
    getTask2(date);
    return await DBHelper.updateAll(task!, title!);
  }

  void getTask() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();

    // print("getTask");
    // print(taskList);
    // print(taskList.toString());
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
    // print(taskList);
  }

  void getTask2(String date) async {
    List<Map<String, dynamic>> tasksListByDate = await DBHelper.query2(date);
    taskListByDate
        .assignAll(tasksListByDate.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTask2(date);
  }

  void deleteAll(Task task) {
    DBHelper.deleteAll(task);
    getTask2(date);
  }

  void autoDelete(Task task, String date) {
    DBHelper.autoDelete(task, date);
    getTask2(date);
  }

  void markTaskCompleted(int id) async {
    await DBHelper.updateCompleted(id);
    getTask2(date);
  }

  void markTaskUnCompleted(int id) async {
    await DBHelper.updateUncopleted(id);
    getTask2(date);
  }
}
