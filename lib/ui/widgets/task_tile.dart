import 'package:final_wpm/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/task.dart';

class TaskTile2 extends StatelessWidget {
  final Task? task;
  TaskTile2(this.task);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${task!.startTime.toString().split(" ")[0]}",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(fontSize: 13, color: Colors.grey[100]),
                ),
              ),
              Text(
                "${task!.endTime.toString().split(" ")[0]}",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(fontSize: 13, color: Colors.grey[100]),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          width: 390,
          margin: EdgeInsets.only(bottom: 30),
          child: Container(
            padding: EdgeInsets.only(top: 10),
            //  width: SizeConfig.screenWidth * 0.78,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              // color: task!.isCompleted == 1
              //     ? Colors.grey.shade800
              //     : _getBGClr(task?.color ?? 0),
              // boxShadow: [
              //   BoxShadow(
              //     color: task!.isCompleted == 1
              //         ? Colors.grey.shade800
              //         : _getBGClr(task?.color ?? 0),
              //     blurRadius: 12,
              //     offset: Offset(0, 6),
              //   )
              // ],
            ),
            child: Row(children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                height: 70,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: task!.isCompleted == 1
                      ? Colors.grey.shade800
                      : _getBGClr(task?.color ?? 0),
                ),
              ),
              Expanded(
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
                        textStyle:
                            TextStyle(fontSize: 15, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: 1.5,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  task!.isCompleted == 1 ? "COMPLETED" : "TODO",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
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
