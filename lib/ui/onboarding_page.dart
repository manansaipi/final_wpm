// ignore_for_file: prefer_const_constructors
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:final_wpm/controllers/task_controller.dart';
import 'package:final_wpm/ui/home_page.dart';
import 'package:final_wpm/ui/theme.dart';
import 'package:final_wpm/ui/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  var _taskController = TaskController();
  DateTime dateTine = DateTime.now();
  var controller = PageController();
  String startTimeW = "08:00 AM";
  String startTimeS = "21:00 PM";
  String sortTimeW = "08.00";
  String sortTimeS = "21.00";
  get titleIntroductionScreenColor => null;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        children: [
          getStartedPage(context),
          wakeUpPage(context),
          sleepPage(context),
        ],
      ),
    ));
  }

  Container getStartedPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/welcome.jpg"),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome,",
                      style: titleIntroductionScreen,
                    ),
                    Row(
                      children: [
                        Text(
                          "Set your",
                          style: titleIntroductionScreen2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Make structure your day",
                      style: noteIntroScreen,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.98,
                    ),
                    Center(
                      child: Text(
                        "You don't neet to create an account and the setup only takes one minute",
                        style: noteIntroScreen,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: MyAddTaskButton(
                        textColor: primaryClr,
                        myColor: Colors.white,
                        label: "Get Started",
                        onTap: () {
                          controller.nextPage(
                              duration: Duration(seconds: 1),
                              curve: Curves.easeInOut);
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.17,
                    ),
                    AnimatedTextKit(
                      pause: Duration(milliseconds: 0),
                      repeatForever: true,
                      animatedTexts: [
                        RotateAnimatedText(
                          duration: Duration(milliseconds: 2000),
                          "Day Plan.",
                          textStyle: titleIntroductionScreenColor1,
                          // transitionHeight: 200,
                        ),
                        RotateAnimatedText(
                          duration: Duration(milliseconds: 2000),
                          "Visual Plan.",
                          textStyle: titleIntroductionScreenColor2,
                          // transitionHeight: 200,
                        ),
                        RotateAnimatedText(
                          duration: Duration(milliseconds: 2000),
                          "Todo List.",
                          textStyle: titleIntroductionScreenColor3,
                          // transitionHeight: 200,
                        ),
                        RotateAnimatedText(
                          duration: Duration(milliseconds: 2000),
                          "Habbit Plan.",
                          textStyle: titleIntroductionScreenColor1,
                          // transitionHeight: 200,
                        ),
                        RotateAnimatedText(
                          duration: Duration(milliseconds: 2000),
                          "Calendar.",
                          textStyle: titleIntroductionScreenColor2,
                          // transitionHeight: 200,
                        ),
                        RotateAnimatedText(
                          duration: Duration(milliseconds: 2000),
                          "Focus Timer.",
                          textStyle: titleIntroductionScreenColor3,
                          // transitionHeight: 200,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // Text("data"),
            // Text("data"),
          ],
        ),
      ),
    );
  }

  Container wakeUpPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/addtask1.jpg"),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "When Do",
                  style: titleIntroductionScreen,
                ),
                Row(
                  children: [
                    Text(
                      "You",
                      style: titleIntroductionScreen2,
                    ),
                    Text(
                      " Wake Up?",
                      style: titleIntroductionScreenColor1,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Simply scroll to adjust the time",
                  style: noteIntroScreen,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.55,
                  child: Container(
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.parse("2022-05-05 08:00:04Z"),
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (dateTime) {
                        setState(() {
                          this.dateTine = dateTime;
                          String split = dateTine.toString().split(" ")[1];
                          startTimeW = split.split(":")[0] +
                              ':' +
                              split.split(":")[1] +
                              ' AM'; // have to dynamic AM or PM
                          sortTimeW =
                              split.split(":")[0] + '.' + split.split(":")[1];
                          print(startTimeW);
                        });
                      },
                      // use24hFormat: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.10,
                ),
                Center(
                  child: Text(
                    "You can change this later in the app",
                    style: noteIntroScreen,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: MyAddTaskButton(
                    textColor: Colors.white,
                    myColor: primaryClr,
                    label: "Continue",
                    onTap: () {
                      controller.nextPage(
                        duration: Duration(seconds: 1),
                        curve: Curves.easeInOut,
                      );
                      _addTaskToDBW();
                    },
                  ),
                )
              ],
            ),

            // Text("data"),
            // Text("data"),
          ],
        ),
      ),
    );
  }

  _addTaskToDBW() async {
    int i = 0;
    String indexDate;
    String indexMonth;
    DateTime dateNow = DateTime.now();
    String splitDateNow = dateNow.toString().split(" ")[0];
    String takeYear = splitDateNow.split("-")[0];
    String takeDate = splitDateNow.split("-")[2];
    String takeMonth = splitDateNow.split("-")[1];
    int dateToInt = int.parse(takeDate);
    int monthToInt = int.parse(takeMonth);
    print(dateNow);
    while (i < 100 && dateToInt < 100) {
      if (dateToInt < 10) {
        indexDate = ("0" + dateToInt.toString());
      } else {
        indexDate = (dateToInt.toString());
      }
      if (monthToInt < 10) {
        indexMonth = ("0" + monthToInt.toString());
      } else {
        indexMonth = (monthToInt.toString());
      }
      String combine = (takeYear + "-" + indexMonth + '-' + indexDate);
      // print(combine);

      DateTime fixDate = DateTime.parse(combine);

      int value = await _taskController.addTask(
        task: Task(
          note: "",
          title: "Wake Up",
          date: DateFormat.yMd().format(fixDate),
          startTime: startTimeW,
          endTime: startTimeW,
          sortTime: sortTimeW,
          repeat: "Daily",
          color: 0,
          mapCoor:
              "LatLng(-2.28497565689798, 187.17053839620769)", //set coordinate
          isCompleted: 0,
          taskCreated: DateTime.now().toString().split(":")[0],
        ),
      );
      dateToInt++;
      i++;
      print(dateToInt);
    }
  }

  Container sleepPage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/addtask1.jpg"),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What Time",
                  style: titleIntroductionScreen,
                ),
                Row(
                  children: [
                    Text(
                      "Do You",
                      style: titleIntroductionScreen2,
                    ),
                    Text(
                      " Sleep?",
                      style: titleIntroductionScreenColor1,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Simply scroll to adjust the time",
                  style: noteIntroScreen,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.55,
                  child: Container(
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.parse("2022-05-05 21:00:04Z"),
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (dateTime) {
                        setState(() {
                          this.dateTine = dateTime;
                          String split = dateTine.toString().split(" ")[1];
                          startTimeS = split.split(":")[0] +
                              ':' +
                              split.split(":")[1] +
                              ' PM'; // have to dynamic AM or PM
                          sortTimeS =
                              split.split(":")[0] + '.' + split.split(":")[1];
                          print(startTimeS);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.10,
                ),
                Center(
                  child: Text(
                    "You can change this later in the app",
                    style: noteIntroScreen,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: MyAddTaskButton(
                    textColor: Colors.white,
                    myColor: primaryClr,
                    label: "Continue",
                    onTap: () {
                      _addTaskToDBS();

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  ),
                )
              ],
            ),

            // Text("data"),
            // Text("data"),
          ],
        ),
      ),
    );
  }

  _addTaskToDBS() async {
    int i = 0;
    String indexDate;
    String indexMonth;
    DateTime dateNow = DateTime.now();
    String splitDateNow = dateNow.toString().split(" ")[0];
    String takeYear = splitDateNow.split("-")[0];
    String takeDate = splitDateNow.split("-")[2];
    String takeMonth = splitDateNow.split("-")[1];
    int dateToInt = int.parse(takeDate);
    int monthToInt = int.parse(takeMonth);
    print(dateNow);
    while (i < 100 && dateToInt < 100) {
      if (dateToInt < 10) {
        indexDate = ("0" + dateToInt.toString());
      } else {
        indexDate = (dateToInt.toString());
      }
      if (monthToInt < 10) {
        indexMonth = ("0" + monthToInt.toString());
      } else {
        indexMonth = (monthToInt.toString());
      }
      String combine = (takeYear + "-" + indexMonth + '-' + indexDate);
      // print(combine);

      DateTime fixDate = DateTime.parse(combine);

      int value = await _taskController.addTask(
        task: Task(
          note: "",
          title: "Sleep",
          date: DateFormat.yMd().format(fixDate),
          startTime: startTimeS,
          endTime: startTimeS,
          sortTime: sortTimeS,
          repeat: "Daily",
          color: 0,
          mapCoor:
              "LatLng(-2.28497565689798, 187.17053839620769)", //set coordinate
          isCompleted: 0,
          taskCreated: DateTime.now().toString().split(":")[0],
        ),
      );
      dateToInt++;
      i++;
      print(dateToInt);
    }
  }

  Widget buildImage(String path) => Center(
        child: Image.asset(
          path,
          width: 3000,

          // height: 2000,
          // height: 10,
        ),
      );
}
