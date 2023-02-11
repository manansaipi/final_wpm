// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:final_wpm/controllers/task_controller.dart';
import 'package:final_wpm/ui/map_page.dart';
import 'package:final_wpm/ui/onboarding_page.dart';
import 'package:final_wpm/ui/services/theme_services.dart';
import 'package:final_wpm/ui/setting_page.dart';
import 'package:final_wpm/ui/services/notification_servieces.dart';
import 'package:final_wpm/ui/theme.dart';
import 'package:final_wpm/ui/widgets/button.dart';
import 'package:final_wpm/ui/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/location_service.dart';
import '../models/task.dart';
import 'UpdatePage.dart';
import 'add_task_bar.dart';

class HomePage extends StatefulWidget {
  static double latitude = 0;
  static double longtitude = 0;
  static var add = 0;
  static int firstIndex = 0;
  static int secondIndex = 0;

  static LocationService locationService = LocationService();

  const HomePage({super.key});

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

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    //TODO: implement initstate
    _taskController.getTask2(DateFormat.yMd()
        .format(DateTime.parse(DateTime.now().toString().split(" ")[0])));

    super.initState();

    HomePage.locationService.locationStream.listen((userLocation) {
      setState(() {
        HomePage.latitude = userLocation.latitude;
        HomePage.longtitude = userLocation.longtitude;
      });
    });
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();

    _taskController.date = DateFormat.yMd().format(DateTime.now());
    // notifyHelper.requestIOSPermissions();
  }

  @override
  void dispose() {
    HomePage.locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyCircleButton(
        label: "+",
        onTap: () {
          Get.to(const AddTaskPage());
          // Get.to(OnBoardingPage());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: _buildCustomScrollView(context),
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
      //               )
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
              color:
                  Get.isDarkMode ? context.theme.backgroundColor : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        ),
        // SliverToBoxAdapter(
        //   child: Column(
        //     children: [
        //       Text(HomePage.latitude.toString()),
        //       Text(HomePage.longtitude.toString()),
        //     ],
        //   ),
        // ),

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

  void add() {
    HomePage.add++;
  }

  SliverList _buildSliverList(BuildContext context) {
    int a = 0;
    var array = [];

    return SliverList(
      delegate: SliverChildBuilderDelegate((_, index) {
        int stop = 999;
        Task task = _taskController.taskListByDate[index];
        String dateSplit = task.date.toString().split(" ")[0];
        int takeDateFromDB = int.parse(task.date.toString().split("/")[1]);
        int takeYearFromDB = int.parse(task.date.toString().split("/")[2]);
        int takeMonthFromDB = int.parse(task.date.toString().split("/")[0]);
        int takeDateFromDateNow = int.parse(dateNow.toString().split("-")[2]);
        int takeYearFromDateNow = int.parse(dateNow.toString().split("-")[0]);
        int takeMonthFromDateNow = int.parse(dateNow.toString().split("-")[1]);
        // print(HomePage.add);
        // print(index);
        if (takeDateFromDB < takeDateFromDateNow &&
                takeMonthFromDateNow >= takeMonthFromDB &&
                takeYearFromDB <= takeYearFromDateNow ||
            takeDateFromDB > takeDateFromDateNow &&
                takeMonthFromDateNow > takeMonthFromDB &&
                takeYearFromDB <= takeYearFromDateNow) {
          _taskController.autoDelete(task, task.date.toString());
          print("autoDelete");
        }

        // Timer(Duration(seconds: 2), () => print(HomePage.array[index]));
        print(task.sortTime);
        print(task.startTime);
        // print(DateTime.now());
        // print(takeDate);
        // print(_taskController.taskList[index].toJson());
        // print(task.date);
        // print(_taskController.taskList.length);
        // var json = task.toJson();
        // print(task.toJson());
        // print(_taskController.taskList);
        int i = 0;

        if (task.date == DateFormat.yMd().format(_selectedDate)) {
          array.add(index);
          print(array);
          String dateNow = DateFormat.yMd().format(_selectedDate);
          // print(index);
          // while (i )
          // print(index);
          DateTime date = DateFormat.jm().parse(task.startTime.toString());
          var myTime = DateFormat("HH:mm").format(date);
          // print(myTim\);
          notifyHelper.scheduledNotification(
            int.parse(myTime.toString().split(":")[0]),
            int.parse(myTime.toString().split(":")[1]),
            task,
          );
          // print(myTime);
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
              child: TaskTile(
                task,
                index,
                array,
                dateNow,
              ),
            ),
          );
        } else {
          return Container();
        }
      }, childCount: _taskController.taskListByDate.length),
    );
  }

  _buildAppBar() {
    String haridantanggal = DateFormat.d().format(
          DateTime.now(),
        ) +
        ",  " +
        DateFormat.y().format(
          DateTime.now(),
        );
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
          const Text("  "),
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                haridantanggal,
                speed: const Duration(milliseconds: 200),
                textStyle: titleBiggerHeadingStyle,
              ),
              TyperAnimatedText(
                DateFormat.EEEE().format(
                  DateTime.now(),
                ),
                speed: const Duration(milliseconds: 500),
                textStyle: titleBiggerHeadingStyle2,
              ),
            ],
            pause: const Duration(milliseconds: 3000),
            repeatForever: true,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(const MapPage());

            //Move to another page using NAVIGATOR
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return SettingPage();
            // }));
          },
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.map,
            color: primaryClr,
            size: 27,
          ),
        ),
        IconButton(
          onPressed: () {
            // print("settings");
            // Get.to(
            // const SettingPage(),
            ThemeService().switchTheme();
            Get.snackbar(
              "Theme Changed !",
              Get.isDarkMode ? "Activated Light Theme" : "Activatd Dark Theme",
              colorText: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
              snackPosition: SnackPosition.TOP,
              backgroundColor:
                  Get.isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
              icon: Container(
                margin: const EdgeInsets.only(left: 7),
                child: Get.isDarkMode
                    ? const Icon(
                        Icons.sunny,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.nightlight_round_outlined,
                        color: Colors.white,
                      ),
              ),
            );
            // );
            // Get.to(OnBoardingPage());
            //Move to another page using NAVIGATOR
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return SettingPage();
            // }));
          },
          icon: Get.isDarkMode
              ? const Icon(
                  Icons.nightlight_round_outlined,
                  color: primaryClr,
                  size: 27,
                )
              : const Icon(
                  Icons.sunny,
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

  _addDateBar() {
    return Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode ? darkBGColor : Colors.grey.shade200,
      ),
      // margin: const EdgeInsets.only(left: 15),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 15, bottom: 10),
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
            textStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
          dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
          onDateChange: (date) {
            setState(() {
              _selectedDate = date;
              // print();
              _taskController.date = DateFormat.yMd().format(_selectedDate);
              datePick = _selectedDate.toString().split(" ")[0];
              _taskController.getTask2(DateFormat.yMd().format(_selectedDate));
              // print(_taskController.taskListByDate.length);
            });
          },
          daysCount: 30,
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      Container(
        height: 280,
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          // padding: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color:
                  Get.isDarkMode ? Colors.grey.shade500 : Colors.grey.shade800,
            ),
            color: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
            borderRadius: const BorderRadius.all(
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
                margin: const EdgeInsets.only(left: 10),
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    task.title == "Wake Up"
                        ? Icon(Icons.alarm, color: _getBGClr(task.color ?? 0))
                        : Icon(Icons.mail_outline,
                            color: _getBGClr(task.color ?? 0)),
                    const SizedBox(
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
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${task.startTime} - ${task.endTime}",
                              style: taskTileTime,
                            ),
                            const SizedBox(
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
                          softWrap: false,
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
                        showDialog(
                            context: context,
                            builder: (context) {
                              String date = (DateFormat.yMd().format(
                                  DateTime.parse(DateTime.now()
                                      .toString()
                                      .split(" ")[0])));
                              return AlertDialog(
                                title: task.repeat == "Daily"
                                    ? const Text(
                                        "Are you sure want to delete this task? This is a repeating task.",
                                        textAlign: TextAlign.center,
                                      )
                                    : const Text(
                                        "Are you sure want to delete this task?",
                                        textAlign: TextAlign.center,
                                      ),
                                titleTextStyle: taskTileNote,
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  task.repeat == "Daily"
                                      ? Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _taskController.delete(task);
                                                Get.back();
                                                Get.back();
                                                _taskController.getTask2(
                                                    DateFormat.yMd()
                                                        .format(_selectedDate));

                                                Get.snackbar(
                                                  "Deleted !",
                                                  "Task Deleted",
                                                  colorText: Colors.white,
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  icon: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 7),
                                                    child: const Icon(
                                                      Icons
                                                          .delete_forever_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1,
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        top: BorderSide(
                                                  width: 1,
                                                  color: Get.isDarkMode
                                                      ? Colors.grey.shade300
                                                      : Colors.grey.shade600,
                                                ))),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        "Delete this task only",
                                                        style: GoogleFonts.lato(
                                                          color: Colors.red,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _taskController.deleteAll(task);
                                                Get.back();
                                                Get.back();
                                                _taskController.getTask2(
                                                    DateFormat.yMd()
                                                        .format(_selectedDate));

                                                Get.snackbar(
                                                  "Deleted !",
                                                  "Task Deleted",
                                                  colorText: Colors.white,
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  icon: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 7),
                                                    child: const Icon(
                                                      Icons
                                                          .delete_forever_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1,
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        top: BorderSide(
                                                  width: 1,
                                                  color: Get.isDarkMode
                                                      ? Colors.grey.shade300
                                                      : Colors.grey.shade600,
                                                ))),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        "Delete all tasks",
                                                        style: GoogleFonts.lato(
                                                          color: Colors.red,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _taskController.delete(task);
                                                Get.back();
                                                Get.back();
                                                _taskController.getTask2(date);

                                                Get.snackbar(
                                                  "Deleted !",
                                                  "Task Deleted",
                                                  colorText: Colors.white,
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  icon: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 7),
                                                    child: const Icon(
                                                      Icons
                                                          .delete_forever_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1,
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        top: BorderSide(
                                                  width: 1,
                                                  color: Get.isDarkMode
                                                      ? Colors.grey.shade300
                                                      : Colors.grey.shade600,
                                                ))),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        "Delete task",
                                                        style: GoogleFonts.lato(
                                                          color: Colors.red,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              );
                            });
                      },
                      clr: Get.isDarkMode
                          ? Colors.grey.shade300
                          : Colors.grey.shade300,
                      context: context),
                  bottomSheetDbButton(
                      icon: Icons.edit,
                      color: _getBGClr(task.color ?? 0),
                      label: "Edit",
                      onTap: () {
                        Get.back();
                        // print(task.title);
                        Get.to(UpdatePage(
                          task: task,
                        ));
                      },
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
                                  margin: const EdgeInsets.only(left: 7),
                                  child: const Icon(
                                    Icons.task_alt_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const SizedBox();
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
              const SizedBox(
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
              const SizedBox(
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
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
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
