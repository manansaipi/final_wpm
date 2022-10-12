import 'package:final_wpm/ui/home_page.dart';

import 'package:final_wpm/ui/setting_page.dart';
import 'package:final_wpm/ui/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
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
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(-6.28497565689798, 107.17053839620769), zoom: 15.5);
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

  // @override
  void initState() {
    //TODO: implement initstate

    // getPolyPoints();
    super.initState();

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
        infoWindow: InfoWindow(title: task.title));
  }

  final _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    BitmapDescriptor? userLiveLocation;
    createMarker(context) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/a.png')
          .then((icon) {
        setState(() {
          userLiveLocation = icon;
        });
      });
    }

    createMarker(context);
    List<Marker> markers = [];
    Task? task;
    int index = _taskController.taskList.length - 1;
    for (int i = 0; i <= index; i++) {
      task = _taskController.taskList[i];
      markers.add(_buildMarker(task));
      markers.add(
        Marker(
            markerId: MarkerId('myLocation'),
            position: LatLng(HomePage.latitude, HomePage.longtitude),
            infoWindow: InfoWindow(title: "You"),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue)),
      );
      // print(task.toJson());
      // print(i);
    }

    return Center(
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
              initialCameraPosition: _initialCameraPosition,
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
}
