import 'package:final_wpm/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task? task;

  TaskTile(this.task);
  @override
  Widget build(BuildContext context) {
    final _taskController = Get.put(TaskController());
    String startTime = task!.startTime.toString().split(" ")[1];
    String endTime = task!.endTime.toString().split(" ")[1];
    var fixStartNumber;
    var fixEndNumber;
    if (startTime == "PM") {
      String firstStartNumber = task!.startTime.toString().split(":")[0];
      String splitForPM = task!.startTime.toString().split(":")[1];
      String secondSplitForPM = splitForPM.split(" ")[0];
      int additionStartTime = 12 + int.parse(firstStartNumber);
      fixStartNumber = additionStartTime.toString() + "." + secondSplitForPM;
    } else {
      fixStartNumber = task!.startTime.toString().split(" ")[0];
    }
    if (endTime == "PM") {
      String firstEndNumber = task!.endTime.toString().split(":")[0];
      String splitForPM = task!.startTime.toString().split(":")[1];
      String secondSplitForPM = splitForPM.split(" ")[0];
      int additionendTime = 12 + int.parse(firstEndNumber);
      fixEndNumber = additionendTime.toString() + "." + secondSplitForPM;
    } else {
      fixEndNumber = task!.endTime.toString().split(" ")[0];
    }

    return Container(
      color: Get.isDarkMode ? context.theme.backgroundColor : Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: TimelineTile(
              startChild: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      fixStartNumber,
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                    Text(
                      fixEndNumber,
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
              ),
              endChild: Container(
                padding: const EdgeInsets.only(left: 5, right: 20),
                width: 390,
                margin: const EdgeInsets.only(bottom: 30, top: 20),
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  //  width: SizeConfig.screenWidth * 0.78,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(16),
                  //   color: task!.isCompleted == 1
                  //       ? Colors.grey.shade800
                  //       : _getBGClr(task?.color ?? 0),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: task!.isCompleted == 1
                  //           ? Colors.grey.shade800
                  //           : _getBGClr(task?.color ?? 0),
                  //       blurRadius: 12,
                  //       offset: Offset(0, 6),
                  //     )
                  //   ],
                  // ),
                  child: Row(children: [
                    // Container(
                    //   margin: EdgeInsets.only(right: 20),
                    //   height: 70,
                    //   width: 40,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(16),
                    //     color: task!.isCompleted == 1
                    //         ? Colors.grey.shade800
                    //         : _getBGClr(task?.color ?? 0),
                    //   ),
                    // ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 15,
                          bottom: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task?.title ?? "",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  color: Colors.grey[200],
                                  size: 18,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${task!.startTime} - ${task!.endTime}",
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        fontSize: 13, color: Colors.grey[100]),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              task?.note ?? "",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontSize: 15, color: Colors.grey[100]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        print("object");

                        task?.isCompleted == 0
                            ? _taskController.markTaskCompleted(task!.id!)
                            : _taskController.markTaskUnCompleted(task!.id!);
                        _taskController.getTask();
                      }),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                task!.isCompleted == 0
                                    ? Icons.circle_outlined
                                    : Icons.task_alt_outlined,
                                color: task!.isCompleted == 0
                                    ? _getBGClr(task?.color ?? 0)
                                    : _getBGClr(task?.color ?? 0) == primaryClr
                                        ? Colors.blue.shade100
                                        : _getBGClr(task?.color ?? 0) ==
                                                Colors.yellow.shade900
                                            ? Colors.yellow.shade100
                                            : _getBGClr(task?.color ?? 0) ==
                                                    Colors.pink
                                                ? Colors.pink.shade100
                                                : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    // Container(
                    //   margin: EdgeInsets.only(left: 10, right: 10, bottom: 12),
                    //   height: 60,
                    //   width: 2,
                    //   color: Colors.grey[200]!.withOpacity(0.7),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(right: 10, bottom: 12),
                    //   child: RotatedBox(
                    //     quarterTurns: 3,
                    //     child: Text(
                    //       task!.isCompleted == 1 ? "COMPLETED" : "TODO",
                    //       style: GoogleFonts.lato(
                    //         textStyle: TextStyle(
                    //             fontSize: 10,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ]),
                ),
              ),
              alignment: TimelineAlign.manual,
              lineXY: 0.15,
              indicatorStyle: IndicatorStyle(
                height: 100,
                width: 50,
                indicator: Container(
                  decoration: BoxDecoration(
                    color: task!.isCompleted == 0
                        ? _getBGClr(task?.color ?? 0)
                        : darkBGColor,
                    // : _getBGClr(task?.color ?? 0) == primaryClr
                    //     ? Colors.blue.shade100
                    //     : _getBGClr(task?.color ?? 0) ==
                    //             Colors.yellow.shade900
                    //         ? Colors.yellow.shade100
                    //         : _getBGClr(task?.color ?? 0) == Colors.pink
                    //             ? Colors.pink.shade100
                    //             : Colors.black,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              beforeLineStyle: LineStyle(
                  thickness: 6,
                  color: task!.isCompleted == 0
                      ? _getBGClr(task?.color ?? 0)
                      : darkBGColor
                  // : _getBGClr(task?.color ?? 0) == primaryClr
                  //     ? Colors.blue.shade100
                  //     : _getBGClr(task?.color ?? 0) == Colors.yellow.shade900
                  //         ? Colors.yellow.shade100
                  //         : _getBGClr(task?.color ?? 0) == Colors.pink
                  //             ? Colors.pink.shade100
                  //             : Colors.black,
                  ),
              afterLineStyle: LineStyle(
                  thickness: 6,
                  color: task!.isCompleted == 0
                      ? _getBGClr(task?.color ?? 0)
                      : darkBGColor
                  // : _getBGClr(task?.color ?? 0) == primaryClr
                  //     ? Colors.blue.shade100
                  //     : _getBGClr(task?.color ?? 0) == Colors.yellow.shade900
                  //         ? Colors.yellow.shade100
                  //         : _getBGClr(task?.color ?? 0) == Colors.pink
                  //             ? Colors.pink.shade100
                  //             : Colors.black,
                  ),
            ),
          )
        ],
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return primaryClr;
      case 1:
        return Colors.yellow.shade900;
      case 2:
        return Colors.pink;
      default:
        return primaryClr;
    }
  }
}
