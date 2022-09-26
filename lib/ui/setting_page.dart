import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:final_wpm/ui/add_task_bar.dart';
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
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // child: Text("setting page"),
      appBar: _appBar(context),
      // body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       flexibleSpace: FlexibleSpaceBar(
      //         background: Image.asset(
      //           "assets/background.jpeg",
      //           width: double.maxFinite,
      //         ),
      //       ),
      //     ),
      //     // _addTaskBar(),
      //     // _addDateBar(),
      //     SizedBox(
      //       height: 10,
      //     ),
      //     // screens[_selectedIndex],
      //     // _showTasks(),
      //   ],
      // ),
    );
  }

  _appBar(BuildContext context) {
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
}
