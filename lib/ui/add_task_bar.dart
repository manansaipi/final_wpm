import 'package:final_wpm/controllers/task_controller.dart';
import 'package:final_wpm/models/task.dart';
import 'package:final_wpm/ui/theme.dart';
import 'package:final_wpm/ui/widgets/button.dart';
import 'package:final_wpm/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9.30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  String _selectedRepeat = "None";
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
      body: Container(
        padding: const EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: MyInputField(
                  title: "Tittle",
                  hint: "Enter title here.",
                  controller: _titleController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: MyInputField(
                  title: "Note",
                  hint: "Enter note here.",
                  controller: _noteController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: MyInputField(
                  title: "Date",
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    onPressed: () {
                      _getDateFromUsers();
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: Colors.grey,
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
                        title: "Start Date",
                        hint: _startTime,
                        widget: IconButton(
                            onPressed: () {
                              _getTimeFromUsers(isStartTime: true);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
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
                            color: Colors.grey,
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
                  title: "Remind",
                  hint: "$_selectedRemind minutes early",
                  widget: DropdownButton(
                    icon: Container(
                      margin: EdgeInsets.only(right: 5, top: 4),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
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
                margin: EdgeInsets.only(top: 4),
                child: MyInputField(
                  title: "Repeat",
                  hint: "$_selectedRepeat",
                  widget: DropdownButton(
                    icon: Container(
                      margin: EdgeInsets.only(right: 5, top: 5),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                    ),
                    iconSize: 30,
                    underline: Container(height: 0),
                    elevation: 4,
                    style: subTitleStyle,
                    items: repeatList.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          child: Text(
                            value,
                          ),
                          value: value,
                        );
                      },
                    ).toList(),
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          _selectedRepeat = newValue!;
                        },
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPallet(),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: MyButton(
                        label: "Create Task",
                        onTap: () {
                          _validateDate();
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
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
      actions: [
        //move to another page not using Get
        // IconButton(
        //     onPressed: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) {
        //         return SettingPage();
        //       }));
        //     },
        //     icon: Icon(
        //       Icons.settings,
        //       color: Get.isDarkMode ? Colors.white : Colors.black,
        //     )),
      ],
    );
  }

  _getDateFromUsers() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(
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
                  padding: const EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(
                    radius: 13,
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
        )
      ],
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
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
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
    print("button is working and My id is " + "$value");
  }
}
