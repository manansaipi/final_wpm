import 'package:final_wpm/assets/repeat_icon.dart';
import 'package:final_wpm/controllers/task_controller.dart';
import 'package:final_wpm/models/task.dart';
import 'package:final_wpm/ui/theme.dart';
import 'package:final_wpm/ui/widgets/button.dart';
import 'package:final_wpm/ui/widgets/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';

class AddTaskPage2 extends StatefulWidget {
  const AddTaskPage2({super.key});

  @override
  State<AddTaskPage2> createState() => _AddTaskPage2State();
}

class _AddTaskPage2State extends State<AddTaskPage2> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9.30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 0;
  List<int> remindList = [
    0,
    5,
    10,
    15,
    20,
  ];
  void _repeat(int index) {
    setState(() {
      _selectedRepeat = index;
      _fixSelectedRepeat = repeatList[_selectedRepeat];
      print(_fixSelectedRepeat);
    });
  }

  String _fixSelectedRepeat = "None";
  int _selectedRepeat = 0;
  List<String> repeatList = [
    "None",
    "Daily",
    "Weakly",
    "Monthly",
  ];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      floatingActionButton: MyAddTaskButton(
        myColor: _getBGClr(_selectedColor),
        label: "Create Task",
        onTap: () {
          _validateDate();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        padding: const EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                child: MyAnotherInputField(
                  cursorCulor: _getBGClr(_selectedColor),
                  title: "What ?",
                  hint: "Answer Emails",
                  controller: _titleController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: MyInputField(
                  title: "When?",
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    onPressed: () {
                      _getDateFromUsers();
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: _getBGClr(_selectedColor),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: MyInputField(
                        title: "Start Time",
                        hint: _startTime,
                        widget: IconButton(
                            onPressed: () {
                              _getTimeFromUsers(isStartTime: true);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: _getBGClr(_selectedColor),
                              size: 20,
                            )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: MyInputField(
                        title: "End Time",
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUsers(isStartTime: false);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: _getBGClr(_selectedColor),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: MyInputField(
                  title: "When Notification?",
                  hint: _selectedRemind != 0
                      ? "$_selectedRemind minutes early"
                      : "At that time ($_selectedRemind minutes )",
                  widget: DropdownButton(
                    icon: Container(
                      margin: EdgeInsets.only(right: 5, top: 4),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: _getBGClr(_selectedColor),
                        size: 30,
                      ),
                    ),
                    // iconSize: 20,
                    underline: Container(height: 0),
                    elevation: 4,
                    style: subTitleStyle,
                    items: remindList.map<DropdownMenuItem<String>>(
                      (int value) {
                        return DropdownMenuItem<String>(
                          child: Text(
                            value.toString(),
                          ),
                          value: value.toString(),
                        );
                      },
                    ).toList(),
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          _selectedRemind = int.parse(newValue!);
                        },
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.87,
                height: 60,
                margin: EdgeInsets.only(top: 30, left: 8),
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Colors.grey.shade700
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GNav(
                    tabBorderRadius: 20,
                    tabBackgroundColor: _getBGClr(_selectedColor),
                    color: Colors.grey,
                    activeColor: Colors.white,
                    onTabChange: _repeat,
                    tabs: [
                      GButton(
                        icon: RepeatIcon.once_1,
                        iconSize: 23,
                        padding: EdgeInsets.only(
                          right: 40,
                          left: 15,
                          top: 15,
                          bottom: 15,
                        ),
                      ),
                      GButton(
                        icon: RepeatIcon.daily,
                        iconSize: 23,
                        padding: EdgeInsets.only(
                          right: 40,
                          left: 15,
                          top: 15,
                          bottom: 15,
                        ),
                      ),
                      GButton(
                        icon: RepeatIcon.weekly,
                        iconSize: 23,
                        padding: EdgeInsets.only(
                          right: 48,
                          left: 16,
                          top: 15,
                          bottom: 15,
                        ),
                      ),
                      GButton(
                        icon: RepeatIcon.monthly,
                        iconSize: 23,
                        padding: EdgeInsets.only(
                          right: 57,
                          left: 8,
                          top: 15,
                          bottom: 15,
                        ),
                      ),
                    ]),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 4),
              //   child: MyInputField(
              //     title: "Repeat",
              //     hint: "$_selectedRepeat",
              //     widget: DropdownButton(
              //       icon: Container(
              //         margin: EdgeInsets.only(right: 5, top: 5),
              //         child: Icon(
              //           Icons.keyboard_arrow_down,
              //           color: _getBGClr(_selectedColor),
              //         ),
              //       ),
              //       iconSize: 30,
              //       underline: Container(height: 0),
              //       elevation: 4,
              //       style: subTitleStyle,
              //       items: repeatList.map<DropdownMenuItem<String>>(
              //         (String value) {
              //           return DropdownMenuItem<String>(
              //             child: Text(
              //               value,
              //             ),
              //             value: value,
              //           );
              //         },
              //       ).toList(),
              //       onChanged: (String? newValue) {
              //         // setState(
              //         //   () {
              //         //     _selectedRepeat = newValue!;
              //         //   },
              //         // );
              //       },
              //     ),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: MyAnotherInputField(
                  cursorCulor: _getBGClr(_selectedColor),
                  title: "Note",
                  hint: "Enter note here.",
                  controller: _noteController,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.87,
                margin: EdgeInsets.only(top: 30, left: 8),
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Colors.grey.shade700
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _colorPallet(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 65,

      elevation: 2,
      // backgroundColor: context.theme.backgroundColor,
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
      title: Row(
        children: [
          Text(
            "Create",
            style: headingStyle,
          ),
          Text(" Task",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: _getBGClr(_selectedColor),
                ),
              )),
        ],
      ),
      // actions: [
      //   //move to another page not using Get
      //   Container(
      //     margin: EdgeInsets.only(right: 18),
      //     child: IconButton(
      //         onPressed: () {},
      //         icon: Icon(
      //           Icons.close_rounded,
      //           color: Get.isDarkMode ? Colors.white : Colors.black,
      //         )),
      //   ),
      // ],
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

  _getDateFromUsers() async {
    DateTime? _pickerDate = await showDatePicker(
      context: (context),
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (_pickerDate != null) {
      setState(
        () {
          _selectedDate = _pickerDate;
        },
      );
    } else {}
  }

  _getTimeFromUsers({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    if (pickedTime != null) {
      String _formatedTime = pickedTime.format(context);
      print(_formatedTime);
      if (pickedTime == null) {
        print("tTime canceled");
      } else if (isStartTime == true) {
        setState(
          () {
            _startTime = _formatedTime;
            print(_startTime);
          },
        );
      } else if (isStartTime == false) {
        setState(
          () {
            _endTime = _formatedTime;
            print(_endTime);
          },
        );
      }
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }

  _colorPallet() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Wrap(
            children: List<Widget>.generate(
              3,
              (int index) {
                return GestureDetector(
                  onTap: (() {
                    setState(
                      () {
                        _selectedColor = index;
                      },
                    );
                  }),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: index == 0
                          ? primaryClr
                          : index == 1
                              ? Colors.yellow.shade900
                              : Colors.pink,
                      child: _selectedColor == index
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 16,
                            )
                          : Container(),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();

      _taskController.getTask();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are required !",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        icon: Container(
          margin: EdgeInsets.only(left: 7),
          child: Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _fixSelectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
    print("button is working and My id is " + "$value");
  }
}
