import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:date_picker_timeline/extra/style.dart';
import 'package:final_wpm/controllers/task_controller.dart';
import 'package:final_wpm/ui/map_page.dart';
import 'package:final_wpm/ui/setting_page.dart';
import 'package:final_wpm/ui/services/notification_servieces.dart';
import 'package:final_wpm/ui/setting_page.dart';
import 'package:final_wpm/ui/services/theme_services.dart';
import 'package:final_wpm/ui/theme.dart';
import 'package:final_wpm/ui/widgets/button.dart';
import 'package:final_wpm/ui/widgets/task_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../models/task.dart';
import 'add_task_bar.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  final Task? task;

  static var s;

  const HomePage({super.key, this.task});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late int s;
  final _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  String dateNow = DateTime.now().toString().split(" ")[0];
  String datePick = DateTime.now().toString().split(" ")[0];
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
    _taskController.getTask();

    return Scaffold(
      appBar: _selectedIndex == 1 || _selectedIndex == 2
          ? _appBar()
          : AppBar(
              toolbarHeight: 0,
              elevation: 0,
            ),

      floatingActionButton: _selectedIndex == 0
          ? MyCircleButton(
              label: "+",
              onTap: () {
                Get.to(AddTaskPage());
              },
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: _selectedIndex == 0
          ? _buildCustomScrollView(context)
          : _selectedIndex == 1
              ? screens[_selectedIndex]
              : _selectedIndex == 2
                  ? screens[_selectedIndex]
                  : Container(),

      //     ? Column(
      //         children: <Widget>[
      //           // _addTaskBar(),
      //           _addDateBar(),
      //           SizedBox(
      //             height: 20,
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
      bottomNavigationBar: Container(
        color: Get.isDarkMode ? darkBGColor : Colors.grey.shade200,
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
            backgroundColor:
                Get.isDarkMode ? darkBGColor : Colors.grey.shade200,
            gap: 8,
            onTabChange: _navigateBottomBar,
            tabs: const [
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
                text: "Favorites",
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomScrollView _buildCustomScrollView(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        SliverToBoxAdapter(
          child: _addDateBar(),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 19,
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? context.theme.backgroundColor
                    : Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          ),
        ),

        // _taskController.taskList == null
        //     ? SliverFillRemaining(
        //         child: Container(
        //           height: 20,
        //           color: Get.isDarkMode
        //               ? context.theme.backgroundColor
        //               : Colors.white,
        //           child: Center(child: Text("No Task for Today !")),
        //         ),
        //       )
        Obx(
          () => _buildSliverList(context),
        ),

        SliverFillRemaining(
          child: Container(
            color:
                Get.isDarkMode ? context.theme.backgroundColor : Colors.white,
          ),
        )
      ],
    );
  }

  SliverList _buildSliverList(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, index) {
        HomePage.s = index;
        print(HomePage.s);
        Task task = _taskController.taskList[HomePage.s];

        // print(_taskController.taskList[].toJson());

        // print(_taskController.taskList.length);
        // var json = task.toJson();
        // print(task.toJson());
        // print(_taskController.taskList);

        if (task.repeat == 'Daily') {
          DateTime date = DateFormat.jm().parse(task.startTime.toString());
          var myTime = DateFormat("HH:mm").format(date);
          // print(myTim\);
          notifyHelper.scheduledNotification(
            int.parse(myTime.toString().split(":")[0]),
            int.parse(myTime.toString().split(":")[1]),
            task,
          );

          return GestureDetector(
            onTap: () {
              _showBottomSheet(
                context,
                task,
              );
            },
            child: Container(
              color:
                  Get.isDarkMode ? context.theme.backgroundColor : Colors.white,
              child: TaskTile(task),
            ),
          );
        } else if (task.date == DateFormat.yMd().format(_selectedDate)) {
          return GestureDetector(
            onTap: () {
              _showBottomSheet(
                context,
                task,
              );
            },
            child: Container(
                color: Get.isDarkMode
                    ? context.theme.backgroundColor
                    : Colors.white,
                child: TaskTile(task)),
          );
        } else {
          return Container();
        }
      }, childCount: _taskController.taskList.length),
    );
  }

  _appBar() {
    return AppBar(
      title: Row(
        children: [
          Text(
            DateFormat.MMMM().format(
              DateTime.now(),
            ),
            style: titleHeadingStyle,
          ),
          Text(" "),
          Text(
            DateFormat.y().format(
              DateTime.now(),
            ),
            style: titleBiggerHeadingStyle,
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: Get.isDarkMode ? darkBGColor : Colors.grey.shade200,
      // leading: GestureDetector(
      //   onTap: () {
      //     ThemeService().switchTheme();
      //     notifyHelper.displayNotification(
      //       title: "Theme Changed",
      //       body: Get.isDarkMode
      //           ? "Activated Light Theme"
      //           : "Activatd Dark Theme",
      //     );
      //   },
      // ),

      //     // notifyHelper.scheduledNotification();
      //   },
      //   child: Icon(
      //     Get.isDarkMode ? Icons.sunny : Icons.nightlight_round_outlined,
      //     size: 20,
      //     color: Get.isDarkMode ? Colors.white : Colors.black,
      //   ),
      // ),
      actions: [
        IconButton(
          onPressed: () {
            print("calender");

            //Move to another page using NAVIGATOR
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return SettingPage();
            // }));
          },
          icon: Icon(
            Icons.calendar_month,
            color: primaryClr,
            size: 27,
          ),
        ),
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
            color: primaryClr,
            size: 27,
          ),
        ),
      ],
    );
  }

  _buildAppBar() {
    return SliverAppBar(
      elevation: 2,
      pinned: true,
      backgroundColor: context.theme.backgroundColor,
      title: Row(
        children: [
          Text(
            DateFormat.MMMM().format(
              DateTime.now(),
            ),
            style: titleHeadingStyle,
          ),
          Text(" "),
          Text(
            DateFormat.y().format(
              DateTime.now(),
            ),
            style: titleBiggerHeadingStyle,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            print("calender");

            //Move to another page using NAVIGATOR
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return SettingPage();
            // }));
          },
          icon: Icon(
            Icons.calendar_month,
            color: primaryClr,
            size: 27,
          ),
        ),
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
            color: primaryClr,
            size: 27,
          ),
        ),
      ],
      expandedHeight: 65,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Get.isDarkMode ? darkBGColor : Colors.grey.shade200,
        ),
      ),
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
                  DateFormat.yMEd().format(
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
            label: "Add Task",
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
      decoration: BoxDecoration(
        color: Get.isDarkMode ? darkBGColor : Colors.grey.shade200,
      ),
      // margin: const EdgeInsets.only(left: 15),
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 15, bottom: 10),
        child: DatePicker(
          DateTime.now(),
          height: 80,
          width: 60,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryClr,

          // dateNow == datePick
          //     ? primaryClr
          //     : Get.isDarkMode
          //         ? Colors.white
          //         : Colors.grey.shade700,
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
              datePick = _selectedDate.toString().split(" ")[0];
              _taskController.getTask();
              print(_taskController.taskList.length);
            });
          },
          daysCount: 30,
        ),
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
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: context.theme.backgroundColor),
        child: Obx(
          () {
            return Container(
              margin: EdgeInsets.only(top: 15),
              child: ListView.builder(
                itemCount: _taskController.taskList.length,
                itemBuilder: (_, index) {
                  // print(_taskController.taskList.length);
                  Task task = _taskController.taskList[index];
                  // print(task.toJson());
                  // print(dateNow);
                  // print(datePick);
                  // print(dateNow == datePick);
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
                                child: Row(
                                  children: [
                                    // _buildTimeLine(
                                    //   _getBGClr(task.color ?? 0),
                                    // ),
                                    TaskTile(
                                      task,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (task.date ==
                      DateFormat.yMd().format(_selectedDate)) {
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
                  } else {
                    return Container();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimeLine(Color color) {
    return Container(
      child: TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0,
        isFirst: true,
        indicatorStyle: IndicatorStyle(
          indicatorXY: 0,
          width: 15,
          indicator: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(width: 5, color: color),
            ),
          ),
        ),
        afterLineStyle: LineStyle(thickness: 2, color: color),
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

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      Container(
        height: 280,
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(horizontal: 10),
          // padding: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color:
                  Get.isDarkMode ? Colors.grey.shade500 : Colors.grey.shade800,
            ),
            color: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          // height: task.isCompleted == 1
          //     ? MediaQuery.of(context).size.width * 0.24
          //     : MediaQuery.of(context).size.width * 0.32,
          // color: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    task.title == "Wake Up"
                        ? Icon(Icons.alarm, color: _getBGClr(task.color ?? 0))
                        : Icon(Icons.mail_outline,
                            color: _getBGClr(task.color ?? 0)),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              task.date ?? "",
                              style: taskTileTime,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${task.startTime} - ${task.endTime}",
                              style: taskTileTime,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Icon(
                              Icons.replay,
                              color: Get.isDarkMode
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade600,
                              size: task.repeat == "Daily" ? 15 : 0,
                            ),
                          ],
                        ),
                        Text(
                          task.title ?? "",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: task.isCompleted == 1
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Container(
              //   height: 6,
              //   width: 120,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              //   ),
              // ),
              // Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  bottomSheetDbButton(
                      icon: Icons.delete,
                      color: task.isCompleted == 0
                          ? _getBGClr(task.color ?? 0)
                          : _getBGClr(task.color ?? 0) == primaryClr
                              ? Colors.blue.shade100
                              : _getBGClr(task.color ?? 0) ==
                                      Colors.yellow.shade900
                                  ? Colors.yellow.shade100
                                  : _getBGClr(task.color ?? 0) == Colors.pink
                                      ? Colors.pink.shade100
                                      : Colors.black,
                      label: "Delete",
                      isDelete: true,
                      onTap: () {
                        _taskController.delete(task);
                        Get.back();
                        Get.snackbar(
                          "Deleted !",
                          "Task Deleted",
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          icon: Container(
                            margin: EdgeInsets.only(left: 7),
                            child: const Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                      clr: Get.isDarkMode
                          ? Colors.grey.shade300
                          : Colors.grey.shade300,
                      context: context),
                  bottomSheetDbButton(
                      icon: Icons.edit,
                      color: _getBGClr(task.color ?? 0),
                      label: "Edit",
                      onTap: () {},
                      clr: Get.isDarkMode
                          ? Colors.grey.shade300
                          : Colors.grey.shade300,
                      context: context),
                  bottomSheetDbButton(
                      color: Colors.green,
                      icon: task.isCompleted == 0
                          ? Icons.circle_outlined
                          : Icons.task_alt,
                      label: task.isCompleted == 0 ? "Complete" : "Uncomplete",
                      onTap: () {
                        Get.back();
                        task.isCompleted == 0
                            ? Get.snackbar(
                                "Updated !",
                                "Task Complate",
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: task.isCompleted == 0
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
                        task.isCompleted == 0
                            ? _taskController.markTaskCompleted(task.id!)
                            : _taskController.markTaskUnCompleted(task.id!);
                      },
                      clr: Colors.grey.shade300,
                      context: context)
                ],
              ),
              // task.isCompleted == 1
              //     ? Container()
              //     : bottomSheetButton(
              //         label: "Task Completed",
              //         onTap: () {
              //           _taskController.markTaskCompleted(task.id!);
              //           Get.back();
              //         },
              //         clr: primaryClr,
              //         context: context),
              // bottomSheetButton(
              //   label: "Delete Task",
              //   onTap: () {
              // _taskController.delete(task);

              //     Get.back();
              //   },
              //   clr: Colors.red,
              //   context: context,
              // ),
              SizedBox(
                height: 15,
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
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        height: 40,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
          // border: Border.all(
          //   width: 1,
          //   color: isClose == true
          //       ? Get.isDarkMode
          //           ? Colors.grey[600]!
          //           : Colors.grey[300]!
          //       : clr,
          // ),
          borderRadius: BorderRadius.circular(10),
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

  bottomSheetDbButton({
    Color? color,
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isDelete = false,
    required BuildContext context,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        height: 70,
        width: 105,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isDelete ? Colors.red : color),
              Text(label,
                  style: isDelete
                      ? deleteTitleStyle
                      : deleteTitleStyle.copyWith(color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
