import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:final_wpm/ui/add_task_bar.dart';
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
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(),
    AddTaskPage(),
    MapPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

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
      bottomNavigationBar: Container(
        color: context.theme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 2,
          ),
          child: GNav(
            padding: EdgeInsets.all(16),
            tabBackgroundColor: primaryClr,
            color: Colors.grey,
            activeColor: Colors.white,
            backgroundColor: context.theme.backgroundColor,
            gap: 8,
            onTabChange: (index) {},
            tabs: [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.map_sharp,
                text: "Maps",
              ),
              GButton(
                icon: Icons.favorite_border,
                text: "Likes",
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: MyCircleButton(
      //   label: "+",
      //   onTap: () {
      //     Get.to(AddTaskPage());
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Get.isDarkMode ? darkBGColor : Colors.white10,
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

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 15),
      child: DatePicker(
        DateTime.now(),
        height: 80,
        width: 60,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey),
        ),
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey),
        ),
        onDateChange: (date) {
          _selectedDate = date;
        },
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
            onPressed: () {},
            icon: Icon(Icons.house_rounded),
            color: primaryClr,
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.abc),
            iconSize: 0,
          ),
          IconButton(
            onPressed: () {
              Get.to(MapPage());
            },
            icon: Icon(Icons.map_outlined),
            iconSize: 30,
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
