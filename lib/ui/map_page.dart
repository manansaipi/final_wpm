import 'package:final_wpm/ui/home_page.dart';

import 'package:final_wpm/ui/setting_page.dart';
import 'package:final_wpm/ui/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
// ignore: const_set_element_type_implements_equals
  String a = "AIzaSyD7SZ5An6Lek2z1IiWwIziKqGw_RIdKLm4";
  // static const _initialCameraPosition =;
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

  // static final Marker _myPositionMarker = Marker(
  //   markerId: MarkerId("_myPosition"),
  //   infoWindow: InfoWindow(title: "You"),
  //   icon: userMarker,
  //   position: myLocation,
  // );
  Marker? userMarker;
  // static final _polyLine = Polyline(
  //   polylineId: PolylineId('route'),
  //   points: polyLineCoordinate,
  //   width: 5,
  // );
  // static final Polygon _polygon = Polygon(
  //   polygonId: PolygonId('_polyGone'),
  //   points: [
  //     myLocation,
  //     presidentUniversity,
  //     LatLng(-6.27888, 107.1622),
  //     LatLng(-6.27999, 107.1622)
  //   ],
  //   strokeWidth: 5,
  //   fillColor: Colors.transparent,
  // );

  // List<LatLng> polyLineCoordinates = [];
  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();

  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     a,
  //     PointLatLng(myLocation.latitude, myLocation.longitude),
  //     PointLatLng(presidentUniversity.latitude, presidentUniversity.longitude),
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach(
  //       (PointLatLng point) => polyLineCoordinates.add(
  //         LatLng(point.latitude, point.longitude),
  //       ),
  //     );
  //     setState(() {});
  //   }
  // }

// static const LatLng myRealTimeLocation =
//       LatLng(latitude, longtitude);
  DateTime _selectedDate = DateTime.now();

  var notifyHelper;

  final PageStorageBucket bucket = PageStorageBucket();
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

  // @override
  void initState() {
    //TODO: implement initstate

    // getPolyPoints();
    super.initState();
    createMarker();

    // HomePage.locationService.locationStream.listen((userLocation) {
    //   setState(() {
    //     HomePage.latitude;
    //     HomePage.longtitude;
    //   });
    // });
    // notifyHelper = NotifyHelper();
    // notifyHelper.initializeNotification();

    // notifyHelper.requestIOSPermissions();
  }

  // @override
  // void dispose() {
  //   HomePage.locationService.dispose();
  //   super.dispose();
  // }

  _buildMarker(Task task) {
    String splitLatLng = task.mapCoor;
    String splitLatLngFI = splitLatLng.split(",")[0];
    String splitLatLngSI = splitLatLng.split(",")[1];
    double latitude1 = double.parse(splitLatLngFI.split("(")[1]);
    double longtitude1 = double.parse(splitLatLngSI.split(")")[0]);
    return Marker(
      markerId: MarkerId(task.id.toString()),
      position: LatLng(latitude1, longtitude1),
      infoWindow: InfoWindow(
          title: task.title, snippet: task.note != "" ? task.note : "None"),
    );
  }

  final _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [];
    Task? task;
    int index = _taskController.taskList.length - 1;
    for (int i = 0; i <= index; i++) {
      task = _taskController.taskList[i];
      markers.add(_buildMarker(task));

      // print(task.toJson());
      // print(i);
    }
    markers.add(
      Marker(
          markerId: MarkerId('myLocation'),
          position: LatLng(HomePage.latitude, HomePage.longtitude),
          infoWindow: InfoWindow(title: "You"),
          icon: userLiveLocation!),
    );
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child:
            //     Row(
            //   children: [
            //     Text('$latitude'),
            //     Text('$longtitude'),
            //   ],
            // )
            Column(
          children: [
            // Text(HomePage.latitude.toString()),
            // Text(HomePage.longtitude.toString()),
            Expanded(
              child: GoogleMap(
                onCameraMoveStarted: (() {
                  setState(() {});
                }),
                onCameraIdle: () {
                  setState(() {});
                },
                // onTap: (LatLng latLng) {
                //   Marker newMarker = Marker(
                //     markerId: MarkerId('userMarker'),
                //     position: LatLng(latLng.latitude, latLng.longitude),
                //     infoWindow: InfoWindow(title: "Your Marker"),
                //     icon: BitmapDescriptor.defaultMarkerWithHue(
                //         BitmapDescriptor.hueRed),
                //   );
                //   userMarker = newMarker;
                //   setState(() {});
                //   print(latLng);
                // },
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
                  zoom: 16.5,
                ),
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                markers: markers.map((e) => e).toSet(),
                // {
                //   // userMarker ?? _presUnivMarker,
                //   // _presUnivMarker,
                // },
              ),
            ),
          ],
        ),

        // body: Column(
        //   children: [
        //     _addTaskBar(),
        //   ],
        // ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 3,
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
        "Maps",
        style: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 20),
            color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}
