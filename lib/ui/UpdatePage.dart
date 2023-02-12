import 'package:final_wpm/assets/repeat_icon.dart';
import 'package:final_wpm/controllers/task_controller.dart';
import 'package:final_wpm/models/task.dart';
import 'package:final_wpm/ui/theme.dart';
import 'package:final_wpm/ui/widgets/button.dart';
import 'package:final_wpm/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import 'add_task_bar.dart';
import 'home_page.dart';

class UpdatePage extends StatefulWidget {
  final Task task;
  UpdatePage({super.key, required this.task});
  static Marker? userMarker;
  static String latlng = "kosong";
  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final TaskController _taskController = Get.put(TaskController());
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";

  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  var splitTime = DateTime.now().toString().split(" ")[1];
  var _sortTime;
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
  late int _selectedRepeat;
  List<String> repeatList = [
    "None",
    "Daily",
    "Weakly",
    "Monthly",
  ];
  int _selectedColor = 0;
  bool statusSwitch = false;

  Icon? _icon;
  List<Map<String, IconData>> icon = [
    {
      "icon": Icons.abc,
    },
    {
      "icon": Icons.access_alarms,
    },
  ];

// ignore: const_set_element_type_implements_equals
  static const LatLng presidentUniversity =
      LatLng(-6.28497565689798, 107.17053839620769);

// ignore: const_set_element_type_implements_equals
  static const LatLng myLocation =
      LatLng(-6.283387245518924, 107.1671712797256);

  static const Marker _presUnivMarker = Marker(
    markerId: MarkerId("_presUniv"),
    infoWindow: InfoWindow(title: "President University"),
    icon: BitmapDescriptor.defaultMarker,
    position: presidentUniversity,
  );
  static final Marker _myPositionMarker = Marker(
    markerId: MarkerId("_myPosition"),
    infoWindow: InfoWindow(title: "You"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: myLocation,
  );

  _showBottomSheet(BuildContext context) {
    Get.bottomSheet(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      Container(
        height: 500,
        color: Colors.transparent,
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 10),
          // padding: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color:
                  Get.isDarkMode ? Colors.grey.shade500 : Colors.grey.shade800,
            ),
            color: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          // height: task.isCompleted == 1
          //     ? MediaQuery.of(context).size.width * 0.24
          //     : MediaQuery.of(context).size.width * 0.32,
          // color: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
          child: Column(
            children: [
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                // margin: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: GoogleMap(
                    onTap: (LatLng latLng) {
                      newMarker = Marker(
                        markerId: MarkerId('userMarker'),
                        position: LatLng(latLng.latitude, latLng.longitude),
                        infoWindow: InfoWindow(title: _titleController.text),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueRed),
                      );
                      UpdatePage.userMarker = newMarker;
                      UpdatePage.latlng = latLng.toString();
                      print(latLng);
                      setState(() {});
                      Get.back();
                      Get.snackbar(
                        "Succeed !",
                        "Locations Saved",
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        icon: Container(
                          margin: EdgeInsets.only(left: 7),
                          child: const Icon(
                            Icons.map,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    // polylines: {
                    //   Polyline(polylineId: PolylineId('route'), points: [
                    //     LatLng(HomePage.latitude, HomePage.longtitude),
                    //     myLocation
                    //   ])
                    // },
                    // polygons: {
                    //   Polygon(
                    //     polygonId: PolygonId('_polygonId'),
                    //     points: [
                    //       LatLng(HomePage.latitude, HomePage.longtitude),
                    //       myLocation,
                    //       LatLng(-6.28497565689798, 107.17053839620769),
                    //       LatLng(-6.284975656, 107.1705383962)
                    //     ],
                    //     strokeWidth: 5,
                    //     fillColor: Colors.transparent,
                    //   )
                    // },
                    // myLocationEnabled: true,
                    // trafficEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(HomePage.latitude, HomePage.longtitude),
                      zoom: 17.5,
                    ),

                    markers: {
                      Marker(
                        markerId: MarkerId('myLocation'),
                        position:
                            LatLng(HomePage.latitude, HomePage.longtitude),
                        infoWindow: const InfoWindow(title: "You"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue),
                      ),
                      newMarker,
                      UpdatePage.userMarker ??
                          const Marker(markerId: MarkerId('value')),
                      // _presUnivMarker,
                    },
                  ),
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
            ],
          ),
        ),
      ),

      enableDrag: false,
    );
  }

  BitmapDescriptor? userLiveLocation =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  void createMarker() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/user.png')
        .then((icon) {
      setState(() {
        userLiveLocation = icon;
      });
    });
  }

  late Marker newMarker;
  @override
  void initState() {
    createMarker();
    // TODO: implement initState
    _sortTime = splitTime.split(":")[0] + "." + splitTime.split(":")[1];
    _titleController.text = widget.task.title!;
    _noteController.text = widget.task.note!;
    print(DateTime.now());
    String date1 = widget.task.date!.split('/')[0];
    if (int.parse(date1) < 10) {
      date1 = ('0' + date1);
    }
    String date2 = widget.task.date!.split('/')[1];
    if (int.parse(date2) < 10) {
      date2 = ('0' + date2);
    }
    String date3 = widget.task.date!.split('/')[2];
    String fixDate = (date3 + "-" + date1 + "-" + date2);
    DateTime date = DateTime.parse(fixDate);
    String dateFormatted = DateFormat('yyyy-MM-dd').format(date);
    _selectedDate = DateTime.parse(dateFormatted);
    _startTime = widget.task.startTime!;
    _endTime = widget.task.endTime!;
    _selectedRepeat = widget.task.repeat == "Once"
        ? 0
        : widget.task.repeat == "Daily"
            ? 1
            : widget.task.repeat == "Weekly"
                ? 2
                : 3;
    _selectedColor = widget.task.color == 0
        ? 0
        : widget.task.color == 1
            ? 1
            : 2;
    print(widget.task.mapCoor);
    _fixSelectedRepeat = widget.task.repeat!;

    String takeCoor1 = widget.task.mapCoor.toString().split(" ")[0];
    String takeCoor2 = widget.task.mapCoor.toString().split(" ")[1];
    String removeKoma1 = takeCoor1.split(",")[0];
    String fixCoor1 = removeKoma1.split("(")[1];
    String fixCoor2 = takeCoor2.split(")")[0];
    newMarker = Marker(
      markerId: MarkerId('userMarker'),
      position: LatLng(double.parse(fixCoor1), double.parse(fixCoor2)),
      infoWindow: InfoWindow(title: widget.task.title),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    super.initState();
    UpdatePage.latlng = widget.task.mapCoor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      floatingActionButton: MyAddTaskButton(
        textColor: Colors.white,
        myColor: _getBGClr(_selectedColor),
        label: "Edit Task",
        onTap: () {
          _validateDate();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        padding: const EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                child: MyTitleInputField(
                  cursorCulor: _getBGClr(_selectedColor),
                  title: "What ?",
                  hint: "Answer Emails",
                  icon: _icon ??
                      Icon(
                        Icons.mail_outline,
                        color: _getBGClr(_selectedColor),
                      ),
                  controller: _titleController,
                  onTap: () {
                    _openIconPicker();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: MyInputField(
                  title: "When?",
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    onPressed: () {
                      _selectedRepeat != 1
                          ? _getDateFromUsers()
                          : Get.snackbar(
                              "Task Daily !",
                              "Cannot change date",
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red,
                              icon: Container(
                                margin: EdgeInsets.only(left: 7),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            );
                      ;
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: _selectedRepeat == 1
                          ? Colors.grey
                          : _getBGClr(_selectedColor),
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
                        hint: widget.task.startTime!,
                        widget: IconButton(
                            onPressed: () {
                              print(_sortTime);

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
                        hint: widget.task.endTime!,
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

              // GestureDetector(
              //   onTap: () {},
              //   child: SizedBox(
              //     height: 100,
              //     width: 100,
              //     child: Container(
              //       child: GoogleMap(
              //         zoomControlsEnabled: false,
              //         zoomGesturesEnabled: false,
              //         scrollGesturesEnabled: false,
              //         rotateGesturesEnabled: false,
              //         mapToolbarEnabled: false,
              //         liteModeEnabled: true,
              //         onTap: (LatLng latLng) {
              //           _showBottomSheet(
              //             context,
              //           );
              //         },
              //         // polylines: {
              //         //   Polyline(polylineId: PolylineId('route'), points: [
              //         //     LatLng(HomePage.latitude, HomePage.longtitude),
              //         //     myLocation
              //         //   ])
              //         // },
              //         // polygons: {
              //         //   Polygon(
              //         //     polygonId: PolygonId('_polygonId'),
              //         //     points: [
              //         //       LatLng(HomePage.latitude, HomePage.longtitude),
              //         //       myLocation,
              //         //       LatLng(-6.28497565689798, 107.17053839620769),
              //         //       LatLng(-6.284975656, 107.1705383962)
              //         //     ],
              //         //     strokeWidth: 5,
              //         //     fillColor: Colors.transparent,
              //         //   )
              //         // },
              //         // myLocationEnabled: true,
              //         // trafficEnabled: true,
              //         initialCameraPosition: CameraPosition(
              //           target: LatLng(HomePage.latitude, HomePage.longtitude),
              //           zoom: 17.5,
              //         ),
              //         // markers: {
              //         //   Marker(
              //         //     markerId: MarkerId('myLocation'),
              //         //     position: LatLng(
              //         //         HomePage.latitude, HomePage.longtitude),
              //         //     infoWindow: InfoWindow(title: "You"),
              //         //     icon: BitmapDescriptor.defaultMarkerWithHue(
              //         //         BitmapDescriptor.hueBlue),
              //         //   ),
              //         //   UpdatePage.userMarker ??
              //         //       Marker(markerId: MarkerId('value')),
              //         //   // _presUnivMarker,
              //         // },
              //       ),
              //     ),
              //   ),
              // ),

              Container(
                margin: EdgeInsets.only(top: 17),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Where ?",
                      style: titleStyle,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 2,
                        color: Get.isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                      )),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 100,
                        child: GoogleMap(
                          onTap: (LatLng) {
                            _showBottomSheet(
                              context,
                            );
                          },
                          mapToolbarEnabled: false,
                          compassEnabled: false,
                          rotateGesturesEnabled: false,
                          scrollGesturesEnabled: false,
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: false,
                          tiltGesturesEnabled: false,
                          myLocationButtonEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target:
                                LatLng(HomePage.latitude, HomePage.longtitude),
                            zoom: 15.5,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId('myLocation'),
                              position: LatLng(
                                  HomePage.latitude, HomePage.longtitude),
                              infoWindow: const InfoWindow(title: "You"),
                              icon: userLiveLocation!,
                            ),
                            AddTaskPage.userMarker ??
                                const Marker(markerId: MarkerId('value')),
                            newMarker
                            // _presUnivMarker,
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      child: UpdatePage.latlng == "kosong"
                          ? Icon(
                              Icons.circle_outlined,
                              color: Get.isDarkMode
                                  ? Colors.grey.shade500
                                  : Colors.grey.shade400,
                            )
                          : Icon(
                              Icons.task_alt_outlined,
                              color: Colors.green,
                            ),
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.87,
                height: 60,
                margin: EdgeInsets.only(top: 30, left: 8, right: 30),
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Colors.grey.shade700
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GNav(
                    selectedIndex: widget.task.repeat == "Once"
                        ? 0
                        : widget.task.repeat == "Daily"
                            ? 1
                            : widget.task.repeat == "Weekly"
                                ? 2
                                : 3,
                    tabBorderRadius: 20,
                    tabBackgroundColor: _getBGClr(_selectedColor),
                    color: Colors.grey,
                    activeColor: Colors.white,
                    onTabChange: _repeat,
                    tabs: const [
                      GButton(
                        icon: RepeatIcon.once_1,
                        iconSize: 23,
                        padding: EdgeInsets.only(
                          right: 40,
                          left: 13,
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
                          left: 14,
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
                margin: EdgeInsets.only(top: 30, left: 8, right: 30),
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
              GestureDetector(
                onTap: () {
                  print('helo');
                  _showBottomSheet(
                    context,
                  );
                },
                child: Container(
                  margin:
                      EdgeInsets.only(right: 20, top: 20, left: 10, bottom: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: 200,
                  width: 20,
                ),
              ),
              SizedBox(
                height: 300,
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
          UpdatePage.latlng = "kosong";
          UpdatePage.userMarker = null;
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          // color: Get.isDarkMode ? Colors.white : Colors.black,
          color: _getBGClr(_selectedColor),
        ),
      ),
      title: Row(
        children: [
          Text(
            "Edit",
            style: headingStyle,
          ),
          Text(
            " Task",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: _getBGClr(_selectedColor),
              ),
            ),
          ),
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

  _openIconPicker() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(
      context,
      iconPackModes: [IconPack.fontAwesomeIcons],
      iconPickerShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
    if (icon != null) {
      print(icon);
      setState(
        () {
          _icon = Icon(
            icon,
            color: _getBGClr(_selectedColor),
          );
        },
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

  _getDateFromUsers() async {
    DateTime? _pickerDate = await showDatePicker(
      context: (context),
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (_pickerDate != null) {
      setState(
        () {
          _selectedDate = _pickerDate;
          print(_selectedDate);
        },
      );
    } else {}
  }

  _getTimeFromUsers({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker(isStartTime);
    if (pickedTime != null) {
      String _formatedTime = pickedTime.format(context);
      String _checkAMorPM = _formatedTime.split(" ")[1];
      String _splitTimeFromPM = _formatedTime.split(" ")[0];
      String _splitTime0 = _splitTimeFromPM.split(":")[0];
      String _splitTime1 = _splitTimeFromPM.split(":")[1];
      print(_formatedTime);
      if (pickedTime == null) {
        print("tTime canceled");
      } else if (isStartTime == true) {
        if (_checkAMorPM == "PM") {
          if (_splitTime0 == "12") {
            _sortTime = _splitTime0 + "." + _splitTime1;
          } else {
            int _addSplitTime = 12 + int.parse(_splitTime0);
            _sortTime = _addSplitTime.toString() + "." + _splitTime1;
          }

          print(_sortTime);
        } else {
          if (_splitTime0 == "12") {
            String combine = "0" + "." + _splitTime1;
            _sortTime = combine;
            print(_sortTime);
          } else {
            _sortTime = _splitTime0.toString() + "." + _splitTime1;
            print(_sortTime);
          }
        }
        setState(
          () {
            _startTime = _formatedTime;
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

  _showTimePicker(bool isStartTime) {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: isStartTime == true
            ? TimeOfDay(
                hour: int.parse(widget.task.startTime!.split(":")[0]),
                minute: int.parse(
                    widget.task.startTime!.split(":")[1].split(" ")[0]),
              )
            : TimeOfDay(
                hour: int.parse(widget.task.endTime!.split(":")[0]),
                minute:
                    int.parse(widget.task.endTime!.split(":")[1].split(" ")[0]),
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
                          ? const Icon(
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
    if (_titleController.text.isNotEmpty && UpdatePage.latlng != "kosong") {
      _addTaskToDb();
      String date = DateFormat.yMd().format(_selectedDate);
      _taskController.getTask2(date);

      _taskController.getTask();
      UpdatePage.userMarker = null;
      Get.back();
      Get.snackbar(
        "Succeed !",
        "Task Updated",
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        icon: Container(
          margin: EdgeInsets.only(left: 7),
          child: const Icon(
            Icons.add_task_rounded,
            color: Colors.white,
          ),
        ),
      );
    } else if (_titleController.text.isEmpty || UpdatePage.latlng == "kosong") {
      print(UpdatePage.latlng);
      Get.snackbar(
        "Required",
        "All fields are required !",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        icon: Container(
          margin: EdgeInsets.only(left: 7),
          child: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  _addTaskToDb() async {
    int? value = widget.task.repeat == "Daily"
        ? await _taskController.updateAllData(
            task: Task(
              note: _noteController.text,
              title: _titleController.text,
              startTime: _startTime,
              endTime: _endTime,
              sortTime: _sortTime,
              repeat: _fixSelectedRepeat,
              color: _selectedColor,
              mapCoor: UpdatePage.latlng,
              isCompleted: widget.task.isCompleted,
            ),
            title: widget.task.title)
        : await _taskController.updateData(
            task: Task(
              note: _noteController.text,
              title: _titleController.text,
              date: DateFormat.yMd().format(_selectedDate),
              startTime: _startTime,
              endTime: _endTime,
              sortTime: _sortTime,
              repeat: _fixSelectedRepeat,
              color: _selectedColor,
              mapCoor: UpdatePage.latlng,
              isCompleted: widget.task.isCompleted,
            ),
            id: widget.task.id);
    print("button is working and My id is " + "$value");
    UpdatePage.latlng = "kosong";
  }
}
