import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:final_wpm/controllers/task_controller.dart';
import 'package:final_wpm/ui/add_task_bar.dart';
import 'package:final_wpm/ui/map_page.dart';
import 'package:final_wpm/ui/setting_page.dart';
import 'package:final_wpm/ui/services/notification_servieces.dart';
import 'package:final_wpm/ui/setting_page.dart';
import 'package:final_wpm/ui/services/theme_services.dart';
import 'package:final_wpm/ui/theme.dart';
import 'package:final_wpm/ui/widgets/button.dart';
import 'package:final_wpm/ui/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> screens = [
    HomePage(),
    MapPage(),
    FavoritePage(),
    Container(
      child: Text(""),
    )
  ];

  final PageStorageBucket bucket = PageStorageBucket();

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
        // appBar:
        //     // _selectedIndex == 3 ? _settingAppBar() :
        //     _appBar(),

        // floatingActionButton: MyCircleButton(
        //   label: "+",
        //   onTap: () {
        //     Get.to(AddTaskPage());
        //   },
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        body: CustomScrollView(
      slivers: [
        //sliver app bar
        SliverAppBar(
          leading: Icon(Icons.menu),
          title: Text("SliveAppbar"),
          expandedHeight: 230,
          // floating: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.pink,
              child: Container(
                padding: EdgeInsets.only(top: 80),
                child: Column(
                  children: [_addTaskBar(), _addDateBar()],
                ),
              ),
            ),
            title: Text("SliverAppbar"),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              Task task = _taskController.taskList[index];
              print(_taskController.taskList.length);
              return GestureDetector(
                onTap: () {
                  _showBottomSheet(
                    context,
                    task,
                  );
                  _taskController.getTask();
                },
                child: TaskTile(
                  task,
                ),
              );
            },
            childCount: _taskController.taskList.length,
          ),
        ),
        // SliverToBoxAdapter(
        //     child: Text()),

        //sliver items
        // SliverToBoxAdapter(
        //   child: Padding(
        //     padding: const EdgeInsets.all(0),
        //     child: ClipRect(
        //       child: Container(
        //         height: 500,
        //         color: Colors.deepPurple.shade100,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    )
        // _selectedIndex == 0
        //     ? Column(
        //         children: [
        //           _addTaskBar(),
        //           _addDateBar(),
        //           SizedBox(
        //             height: 10,
        //           ),
        //           // screens[_selectedIndex],
        //           _showTasks(),
        //         ],
        //       )
        //     : _selectedIndex == 1
        //         ? Column(
        //             children: [
        //               SizedBox(
        //                 height: 10,
        //               ),
        //               screens[_selectedIndex],
        //             ],
        //           )
        //         : _selectedIndex == 2
        //             ? Column(
        //                 children: [
        //                   SizedBox(
        //                     height: 10,
        //                   ),
        //                   screens[_selectedIndex],
        //                 ],
        //               )
        //             : Column(
        //                 children: [
        //                   SizedBox(
        //                     height: 10,
        //                   ),
        //                   screens[_selectedIndex],
        //                 ],
        //               ),
        // bottomNavigationBar: Container(
        //   color: context.theme.backgroundColor,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: 15.0,
        //       vertical: 2,
        //     ),
        //     child: GNav(
        //       padding: EdgeInsets.all(16),
        //       tabBackgroundColor: primaryClr,
        //       color: Colors.grey,
        //       activeColor: Colors.white,
        //       backgroundColor: context.theme.backgroundColor,
        //       gap: 8,
        //       onTabChange: _navigateBottomBar,
        //       tabs: [
        //         GButton(
        //           icon: Icons.home,
        //           text: "Home",
        //         ),
        //         GButton(
        //           icon: Icons.map_sharp,
        //           text: "Maps",
        //         ),
        //         GButton(
        //           icon: Icons.favorite_border,
        //           text: "Favorite",
        //         ),
        //         GButton(
        //           icon: Icons.question_mark,
        //           text: "??",
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }

  _settingAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.white,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      title: Text(
        "Settings",
        style: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 20),
            color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }

  _appBar() {
    return AppBar(
      title: _selectedIndex == 0
          ? Text("Home")
          : _selectedIndex == 1
              ? Text("Maps")
              : _selectedIndex == 2
                  ? Text("Favorite")
                  : Text("?"),
      centerTitle: true,
      titleTextStyle: headingStyle,
      elevation: 0,
      backgroundColor: Get.isDarkMode ? darkBGColor : Colors.white10,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: "Theme Changed",
            body: Get.isDarkMode
                ? "Activated Light Theme"
                : "Activatd Dark Theme",
          );

          // notifyHelper.scheduledNotification();
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
              Get.to(
                SettingPage(),
              );
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
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 5,
      ),
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
          MyButton(
            label: "Create Task",
            onTap: () async {
              await Get.to(
                AddTaskPage(),
              );
              _taskController.getTask();
            },
          )
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
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
        ),
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
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
            icon: Icon(
              Icons.house_rounded,
            ),
            color: primaryClr,
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.abc,
            ),
            iconSize: 0,
          ),
          IconButton(
            onPressed: () {
              Get.to(
                MapPage(),
              );
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

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              print(_taskController.taskList.length);
              Task task = _taskController.taskList[index];
              // print(task.toJson());
              if (task.repeat == 'Daily') {
                DateTime date =
                    DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                // print(myTime);
                notifyHelper.scheduledNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                  task,
                );
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                context,
                                task,
                              );
                            },
                            child: TaskTile(
                              task,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                context,
                                task,
                              );
                            },
                            // child: TaskTile(
                            //   task,
                            // ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.width * 0.34
            : MediaQuery.of(context).size.width * 0.42,
        color: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            Spacer(),
            task.isCompleted == 1
                ? Container()
                : bottomSheetButton(
                    label: "Task Completed",
                    onTap: () {
                      _taskController.markTaskCompleted(task.id!);
                      Get.back();
                    },
                    clr: primaryClr,
                    context: context),
            bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);

                Get.back();
              },
              clr: Colors.red,
              context: context,
            ),
            SizedBox(
              height: 20,
            ),
            bottomSheetButton(
              label: "Cancel",
              onTap: () {
                Get.back();
              },
              clr: Colors.white10,
              isClose: true,
              context: context,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 35,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: isClose == true ? Colors.transparent : clr,
          border: Border.all(
            width: 1,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
