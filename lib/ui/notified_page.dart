import 'package:final_wpm/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';

class NotifiedPage extends StatefulWidget {
  final String? label;
  final Task? task;

  const NotifiedPage({super.key, required this.label, this.task});

  @override
  State<NotifiedPage> createState() => _NotifiedPageState();
}

class _NotifiedPageState extends State<NotifiedPage> {
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(-6.28440763988385, 107.16877268350883), zoom: 15.5);
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
        title: Text(this.widget.label.toString().split("|")[0],
            style: headingStyle),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
      ),

      // Center(
      //   child: Container(
      //     height: 400,
      //     width: 350,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(20),
      //       color: Get.isDarkMode ? Colors.grey.shade600 : Colors.grey[100],
      //     ),
      //     child: Center(
      //       child:
      //           Text(this.label.toString().split("|")[1], style: headingStyle),
      //     ),
      //   ),
      // ),
    );
  }
}
