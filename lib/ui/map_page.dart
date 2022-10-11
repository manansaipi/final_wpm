import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:final_wpm/models/location_service.dart';
import 'package:final_wpm/models/user_location.dart';

import 'package:final_wpm/ui/home_page.dart';
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
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

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
  static final Marker _myPositionMarker = Marker(
    markerId: MarkerId("_myPosition"),
    infoWindow: InfoWindow(title: "You"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: myLocation,
  );
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

  double latitude = 0;
  double longtitude = 0;
// static const LatLng myRealTimeLocation =
//       LatLng(latitude, longtitude);
  DateTime _selectedDate = DateTime.now();

  var notifyHelper;

  final PageStorageBucket bucket = PageStorageBucket();
  LocationService locationService = LocationService();
  @override
  void initState() {
    //TODO: implement initstate

    // getPolyPoints();
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    locationService.locationStream.listen((userLocation) {
      setState(() {
        latitude = userLocation.latitude;
        longtitude = userLocation.longtitude;
      });
    });

    // notifyHelper.requestIOSPermissions();
  }

  // @override
  // void dispose() {
  //   locationService.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
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
          // Text('$latitude'),
          // Text('$longtitude'),
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
              initialCameraPosition: _initialCameraPosition,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              markers: {
                Marker(
                  markerId: MarkerId('myLocation'),
                  position: LatLng(
                    latitude,
                    longtitude,
                  ),
                  infoWindow: InfoWindow(title: "You"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                ),
                // _presUnivMarker,
                // _myPositionMarker,
              },
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
