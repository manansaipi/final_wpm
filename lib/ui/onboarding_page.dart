// ignore_for_file: prefer_const_constructors
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:final_wpm/ui/theme.dart';
import 'package:final_wpm/ui/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  DateTime dateTine = DateTime.now();
  var controller = PageController();

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
                      width: MediaQuery.of(context).size.width * 0.32,
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
                      initialDateTime: DateTime.parse("08:00:00"),
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (dateTime) =>
                          setState(() => this.dateTine = dateTime),
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
                          curve: Curves.easeInOut);
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
                  height: MediaQuery.of(context).size.width * 0.75,
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
                          curve: Curves.easeInOut);
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

  Widget buildImage(String path) => Center(
        child: Image.asset(
          path,
          width: 3000,

          // height: 2000,
          // height: 10,
        ),
      );
}
