import 'package:final_wpm/models/user_location.dart';
import 'package:final_wpm/ui/home_page.dart';
import 'package:final_wpm/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';
import 'map_page.dart';

class NotifiedPage extends StatefulWidget {
  final String? label;
  final Task? task;

  const NotifiedPage({super.key, required this.label, this.task});

  @override
  State<NotifiedPage> createState() => _NotifiedPageState();
}

class _NotifiedPageState extends State<NotifiedPage> {
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(-6.28440763988385, 107.16877268350883), zoom: 15.5);

  double? latitude1;
  double? longtitude1;
  String? userMarker;

  @override
  void initState() {
    //TODO: implement initstate

    super.initState();
    setState(() {
      userMarker = this.widget.label.toString().split("|")[1];
    });

    // MapPage.locationService.locationStream.listen((userLocation) {
    //   setState(() {
    //     MapPage.latitude = userLocation.latitude;
    //     MapPage.longtitude = userLocation.longtitude;
    //   });
    // });

    // notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    // const LatLng userLocation = LatLng(latitude, longitude);
    final _taskController = Get.put(TaskController());
    String splitLatLng = this.widget.label.toString().split("|")[1];
    String splitLatLngFI = splitLatLng.split(",")[0];
    String splitLatLngSI = splitLatLng.split(",")[1];
    latitude1 = double.parse(splitLatLngFI.split("(")[1]);
    longtitude1 = double.parse(splitLatLngSI.split(")")[0]);
    print(userMarker);
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
        leading: Row(
          children: [
            // IconButton(
            //   onPressed: () {
            //     print(_taskController.taskList.length);
            //   },
            //   icon: Icon(Icons.home),
            // ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Get.isDarkMode ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ],
        ),
        title: Text(this.widget.label.toString().split("|")[0],
            style: headingStyle),
      ),
      body: Column(
        children: [
          // Text(userMarker!),
          // Text(splitLatLng!),
          // Text(latitude.toString()),
          // Text(longtitude.toString()),
          // Text(MapPage.latitude.toString()),
          // Text(MapPage.longtitude.toString()),
          Expanded(
            child: GoogleMap(
              // polylines: {
              //   Polyline(
              //       polylineId: PolylineId('route'),
              //       points: polyLineCoordinates)
              // },
              // polygons: {_polygon},
              // myLocationEnabled: true,
              // trafficEnabled: true,
              onCameraMoveStarted: (() {
                setState(() {});
              }),

              onCameraIdle: () {
                setState(() {});
              },
              initialCameraPosition: _initialCameraPosition,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              markers: {
                Marker(
                  markerId: MarkerId('myLocation'),
                  position: LatLng(HomePage.latitude, HomePage.longtitude),
                  infoWindow: InfoWindow(title: "You"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                ),
                Marker(
                  markerId: MarkerId('userMarker'),
                  position: LatLng(latitude1!, longtitude1!),
                  infoWindow: InfoWindow(
                    title: this.widget.label.toString().split("|")[0],
                    snippet: this.widget.label.toString().split("|")[2] == ""
                        ? "None"
                        : this.widget.label.toString().split("|")[2],
                  ),
                )

                //   // _presUnivMarker,
                //   // _myPositionMarker,
              },
            ),
          ),
        ],
      ),

      // Center(
      //   child: Container(
      //     height: 400,
      //     width: 350,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(20),
      //       color: Get.isDarkMode ? Colors.grey.shade600 : Colors.grey[100],
      //     ),
      //     child: Center(
      //       child:
      //           Text(this.label.toString().split("|")[1], style: headingStyle),
      //     ),
      //   ),
      // ),
    );
  }
}
