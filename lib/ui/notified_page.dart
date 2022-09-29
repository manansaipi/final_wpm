import 'package:final_wpm/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  final Task? task;

  const NotifiedPage({super.key, required this.label, this.task});

  @override
  Widget build(BuildContext context) {
    final _taskController = Get.put(TaskController());

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
        leading: Row(
          children: [
            // IconButton(
            //   onPressed: () {
            //     print(_taskController.taskList.length);
            //   },
            //   icon: Icon(Icons.home),
            // ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Get.isDarkMode ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ],
        ),
        title: Center(
            child:
                Text(this.label.toString().split("|")[0], style: headingStyle)),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode ? Colors.grey.shade600 : Colors.grey[100],
          ),
          child: Center(
            child:
                Text(this.label.toString().split("|")[1], style: headingStyle),
          ),
        ),
      ),
    );
  }
}
