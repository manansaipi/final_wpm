import 'package:final_wpm/ui/home_page.dart';
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
  static var timeDistance;
  TaskTile(this.task);
  @override
  Widget build(BuildContext context) {
    final _taskController = Get.put(TaskController());
    String startTime = task!.startTime.toString().split(" ")[1];
    String endTime = task!.endTime.toString().split(" ")[1];
    String firstStartNumber = task!.startTime.toString().split(":")[0];
    String splitForPMST = task!.startTime.toString().split(":")[1];
    String secondSplitForPMST = splitForPMST.split(" ")[0];
    String firstEndNumber = task!.endTime.toString().split(":")[0];
    int additionStartTime = 12 + int.parse(firstStartNumber);
    String splitForPMET = task!.endTime.toString().split(":")[1];
    String splitForPMET2 = splitForPMET.toString().split(" ")[0];

    String firstNumberET = task!.endTime.toString().split(":")[0];

    String secondSplitForPMET = splitForPMET.split(" ")[0];
    late String fixStartNumber;
    late String fixEndNumber;

    if (startTime == "PM") {
      if (firstStartNumber == "12") {
        fixStartNumber = "$firstStartNumber.$secondSplitForPMST";
      } else {
        fixStartNumber = "$additionStartTime.$secondSplitForPMST";
      }
    } else {
      String split0 = task!.startTime.toString().split(":")[0];
      if (split0 == "12") {
        fixStartNumber = "0" + "." + secondSplitForPMST;
      } else {
        fixStartNumber = firstStartNumber + "." + secondSplitForPMST;
      }
    }
    if (endTime == "PM") {
      if (firstEndNumber == "12") {
        fixEndNumber = firstEndNumber + "." + splitForPMET2;
        print("object");
      } else {
        int additionendTime = 12 + int.parse(firstEndNumber);
        fixEndNumber = additionendTime.toString() + "." + secondSplitForPMET;
      }
    } else {
      String split0 = task!.endTime.toString().split(":")[0];
      if (split0 == "12") {
        fixEndNumber = "24" + "." + secondSplitForPMET;
      } else {
        fixEndNumber = firstNumberET + "." + secondSplitForPMET;
      }
    }
    late var findHeight2 =
        (double.parse(fixEndNumber) - double.parse(fixStartNumber));
    late var findHeight = (int.parse(fixEndNumber.split(".")[0]) -
        int.parse(fixStartNumber.split(".")[0]));
    late var hei = findHeight2 == 0
        ? 38
        : findHeight2 <= 1
            ? (38 + findHeight2) * 1.2
            : ((findHeight + 7) * 5) * 1.7;
    late var splitFixET = fixEndNumber.split(".")[0];
    late var splitFixST = fixStartNumber.split(".")[0];

    double findTimeDistance =
        double.parse(fixEndNumber) - double.parse(fixStartNumber);
    String toPrecission = findTimeDistance.toStringAsFixed(2);
    String splitTimeDistanceHour = toPrecission.toString().split(".")[0];

    String splitTimeDistanceMinute = toPrecission.toString().split(".")[1];
    // String secondSplitTimeDistance = toPrecission.toString().split("")[1];

    if (findTimeDistance < 1) {
      if (splitTimeDistanceHour == "0" && splitTimeDistanceMinute == "00") {
        timeDistance = "";
      } else {
        if (int.parse(splitTimeDistanceMinute) < 10) {
          int one = int.parse(splitTimeDistanceMinute);
          timeDistance = " ( " + one.toString() + " min ) ";
        } else {
          timeDistance = " ( " + splitTimeDistanceMinute + " min ) ";
        }
      }
    } else {
      if (int.parse(splitTimeDistanceMinute) > 60) {
        int addHour = int.parse(splitTimeDistanceHour) + 1;
        int substractionMinute = int.parse(splitTimeDistanceMinute) - 60;

        timeDistance = " ( $addHour hr, $substractionMinute min ) ";
      } else {
        if (splitTimeDistanceMinute == "00") {
          timeDistance = " ( " + splitTimeDistanceHour + " hr ) ";
        } else {
          if (int.parse(splitTimeDistanceMinute) < 10) {
            int minute = int.parse(splitTimeDistanceMinute);
            timeDistance = " ( $splitTimeDistanceHour hr, $minute min ) ";
          } else {
            timeDistance =
                " ( $splitTimeDistanceHour hr, $splitTimeDistanceMinute min ) ";
          }
        }
      }
    }

    late int clock1 = int.parse(splitFixET) - 1;
    late String fixClock1 = clock1.toString() + "." + "00";
    late int clock2 = int.parse(splitFixET) - 2;
    late String fixClock2 = clock2.toString() + "." + "00";
    late int clock3 = int.parse(splitFixET) - 3;
    late String fixClock3 = clock3.toString() + "." + "00";
    late int clock4 = int.parse(splitFixET) - 4;
    late String fixClock4 = clock4.toString() + "." + "00";
    late int clock5 = int.parse(splitFixET) - 5;
    late String fixClock5 = clock5.toString() + "." + "00";
    late double clock6 =
        ((double.parse(splitFixET) - double.parse(splitFixST)) / 2) +
            double.parse(splitFixST) -
            1;
    late String scndlock6 = clock6.toString().split(".")[0];
    late String fixClock6 = scndlock6 + "." + "00";
    late double clock7 =
        ((double.parse(splitFixET) - double.parse(splitFixST)) / 2) +
            double.parse(splitFixST) +
            1;
    late String scndClock7 = clock7.toString().split(".")[0];
    late String fixClock7 = scndClock7 + "." + "00";
    late double clock8 =
        ((double.parse(splitFixET) - double.parse(splitFixST)) / 2) +
            double.parse(splitFixST);
    late String scndClock8 = clock8.toString().split(".")[0];
    late String fixClock8 = scndClock8 + "." + "00";

    return Container(
      color: Get.isDarkMode ? context.theme.backgroundColor : Colors.white,
      child: Row(
        children: [
          SizedBox(
            height: hei >= 200 ? 200 : hei.toDouble() + 140,

            // height: (int.parse(fixEndNumber.split(".")[0]) -
            //         int.parse(fixStartNumber.split(".")[0])) *
            //     19,
            width: MediaQuery.of(context).size.width * 1,
            child: TimelineTile(
              // hasIndicator: false,
              isFirst: HomePage.s == 0 ? true : false,
              isLast: HomePage.s == _taskController.taskList.length - 1
                  ? true
                  : false,
              startChild: Container(
                margin: EdgeInsets.only(bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    findHeight == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                fixStartNumber,
                                style: taskTileTime,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              findHeight == 1
                                  ? Text(
                                      fixStartNumber,
                                      style: GoogleFonts.lato(
                                        textStyle: taskTileTime,
                                      ),
                                    )
                                  : findHeight == 2
                                      ? Column(
                                          children: [
                                            Text(
                                              fixStartNumber,
                                              style: GoogleFonts.lato(
                                                textStyle: taskTileTime,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 100,
                                            ),
                                            Text(
                                              fixClock1,
                                              style: GoogleFonts.lato(
                                                textStyle: taskTileTime,
                                              ),
                                            ),
                                          ],
                                        )
                                      : findHeight == 3
                                          ? Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    fixStartNumber,
                                                    style: GoogleFonts.lato(
                                                      textStyle: taskTileTime,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                  ),
                                                  Text(
                                                    fixClock2,
                                                    style: GoogleFonts.lato(
                                                      textStyle: taskTileTime,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                  ),
                                                  Text(
                                                    fixClock1,
                                                    style: GoogleFonts.lato(
                                                      textStyle: taskTileTime,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : findHeight == 4
                                              ? Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        fixStartNumber,
                                                        style: GoogleFonts.lato(
                                                          textStyle:
                                                              taskTileTime,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 33,
                                                      ),
                                                      Text(
                                                        fixClock3,
                                                        style: GoogleFonts.lato(
                                                          textStyle:
                                                              taskTileTime,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 33,
                                                      ),
                                                      Text(
                                                        fixClock2,
                                                        style: GoogleFonts.lato(
                                                          textStyle:
                                                              taskTileTime,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 33,
                                                      ),
                                                      Text(
                                                        fixClock1,
                                                        style: GoogleFonts.lato(
                                                          textStyle:
                                                              taskTileTime,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : findHeight == 6
                                                  ? Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            fixStartNumber,
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle:
                                                                  taskTileTime,
                                                            ),
                                                          ),
                                                          Text(
                                                            fixClock5,
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle:
                                                                  taskTileTime,
                                                            ),
                                                          ),
                                                          Text(
                                                            fixClock4,
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle:
                                                                  taskTileTime,
                                                            ),
                                                          ),
                                                          Text(
                                                            fixClock3,
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle:
                                                                  taskTileTime,
                                                            ),
                                                          ),
                                                          Text(
                                                            fixClock2,
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle:
                                                                  taskTileTime,
                                                            ),
                                                          ),
                                                          Text(
                                                            fixClock1,
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle:
                                                                  taskTileTime,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            fixStartNumber,
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle:
                                                                  taskTileTime,
                                                            ),
                                                          ),
                                                          Text(
                                                            fixClock6,
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle:
                                                                  taskTileTime,
                                                            ),
                                                          ),
                                                          Text(
                                                            fixClock8,
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle:
                                                                  taskTileTime,
                                                            ),
                                                          ),
                                                          Text(
                                                            fixClock7,
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle:
                                                                  taskTileTime,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                              Text(
                                fixEndNumber,
                                style: GoogleFonts.lato(
                                  textStyle: taskTileTime,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              endChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5, right: 20),
                    width: 390,
                    margin: const EdgeInsets.only(bottom: 30, top: 40),
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
                            margin: const EdgeInsets.only(
                              left: 15,
                              bottom: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 300),
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      color: Get.isDarkMode
                                          ? task?.isCompleted == 1
                                              ? Colors.grey.shade400
                                              : Colors.white
                                          : task?.isCompleted == 1
                                              ? Colors.grey.shade500
                                              : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: task?.isCompleted == 1
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                  child: Text(
                                    task?.title ?? "",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      color: Get.isDarkMode
                                          ? Colors.grey.shade400
                                          : Colors.grey.shade600,
                                      size: 18,
                                    ),
                                    SizedBox(width: 4),
                                    findTimeDistance != 0
                                        ? Text(
                                            "${task!.startTime} - ${task!.endTime}",
                                            style: taskTileTime,
                                          )
                                        : Text(
                                            "${task!.startTime}",
                                            style: taskTileTime,
                                          ),
                                    Text(
                                      timeDistance,
                                      style: taskTileTime,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.replay,
                                      size: task?.repeat == "Daily" ? 15 : 0,
                                      color: Get.isDarkMode
                                          ? Colors.grey.shade400
                                          : Colors.grey.shade600,
                                    )
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  task?.note ?? "",
                                  style: taskTileNote,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            print("object");
                            task?.isCompleted == 0
                                ? Get.snackbar(
                                    "Updated !",
                                    "Task Complate",
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: task?.isCompleted == 0
                                        ? Colors.green
                                        : Colors.grey,
                                    icon: Container(
                                      margin: EdgeInsets.only(left: 7),
                                      child: const Icon(
                                        Icons.task_alt_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : SizedBox();
                            task?.isCompleted == 0
                                ? _taskController.markTaskCompleted(task!.id!)
                                : _taskController
                                    .markTaskUnCompleted(task!.id!);

                            _taskController.getTask();
                          }),
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            child: Stack(
                              children: [
                                Center(
                                  child: Icon(
                                    task!.isCompleted == 0
                                        ? Icons.circle_outlined
                                        : Icons.task_alt_outlined,
                                    color: task!.isCompleted == 0
                                        ? _getBGClr(task?.color ?? 0)
                                        : _getBGClr(task?.color ?? 0) ==
                                                primaryClr
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
                ],
              ),
              alignment: TimelineAlign.manual,
              lineXY: 0.2,
              indicatorStyle: IndicatorStyle(
                height: hei >= 200 ? 200 : hei.toDouble() * 1.5 + 3,
                width: 55,
                indicator: Container(
                  // ignore: sort_child_properties_last
                  child: task?.title == "Wake Up"
                      ? Icon(
                          Icons.alarm,
                          color: task!.isCompleted == 1
                              ? _getBGClr(task?.color ?? 0)
                              : Colors.white,
                        )
                      : task?.title == "Sleep"
                          ? Icon(
                              Icons.nightlight_round_outlined,
                              color: task!.isCompleted == 1
                                  ? _getBGClr(task?.color ?? 0)
                                  : Colors.white,
                            )
                          : Icon(
                              Icons.mail_outline,
                              color: task!.isCompleted == 1
                                  ? _getBGClr(task?.color ?? 0)
                                  : Colors.white,
                            ),
                  decoration: BoxDecoration(
                    color: task!.isCompleted == 0
                        ? _getBGClr(task?.color ?? 0)
                        : Get.isDarkMode
                            ? darkBGColor
                            : Colors.grey.shade300,
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
                    : Get.isDarkMode
                        ? darkBGColor
                        : Colors.grey.shade300,
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
                    : Get.isDarkMode
                        ? darkBGColor
                        : Colors.grey.shade300,
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
