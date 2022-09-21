import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:final_wpm/ui/add_task_bar.dart';
import 'package:final_wpm/ui/home_page.dart';
import 'package:final_wpm/ui/map_page.dart';
import 'package:final_wpm/ui/setting_page.dart';
import 'package:final_wpm/ui/services/notification_servieces.dart';
import 'package:final_wpm/ui/setting_page.dart';
import 'package:final_wpm/ui/services/theme_services.dart';
import 'package:final_wpm/ui/theme.dart';
import 'package:final_wpm/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  int currentTab = 0;
  final List<Widget> screens = [
    MapPage(),
    AddTaskPage(),
    MapPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = MapPage();

  @override
  void initState() {
    //TODO: implement initstate

    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    // notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: _addBottomNavBar(),
      floatingActionButton: MyCircleButton(
        label: "+",
        onTap: () {
          Get.to(AddTaskPage());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          _addTaskBar(),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Light Theme"
                  : "Activatd Dark Theme");
        },
        child: Icon(
          Get.isDarkMode ? Icons.sunny : Icons.nightlight_round_outlined,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              print("settings");
              Get.to(SettingPage());
              //Move to another page using NAVIGATOR
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return SettingPage();
              // }));
            },
            icon: Icon(
              Icons.settings,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            )),
      ],
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(
                    DateTime.now(),
                  ),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                ),
              ],
            ),
          ),
          MyButton(label: "Add Task", onTap: () => Get.to(AddTaskPage()))
        ],
      ),
    );
  }

  _addBottomNavBar() {
    return BottomAppBar(
      color: Get.isDarkMode ? Colors.grey[900] : Colors.white70,
      elevation: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.abc),
          //   iconSize: 0,
          // ),
          IconButton(
            onPressed: () {
              Get.to(HomePage());
            },
            icon: Icon(Icons.house_outlined),
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.abc),
            iconSize: 0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.map_sharp),
            iconSize: 30,
            color: Colors.blue[300],
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.abc),
          //   iconSize: 0,
          // ),
        ],
      ),
    );
  }
}
