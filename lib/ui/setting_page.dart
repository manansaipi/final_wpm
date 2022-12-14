import 'package:final_wpm/ui/services/notification_servieces.dart';
import 'package:final_wpm/ui/services/theme_services.dart';
import 'package:final_wpm/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    //TODO: implement initstate

    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    // notifyHelper.requestIOSPermissions();
  }

  var notifyHelper;
  bool val1 = Get.isDarkMode;

  onChangeFunction1(bool newValue1) {
    setState(
      () {
        ThemeService().switchTheme();
        val1 = newValue1;
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_customSwitch("Dark Mode", val1, onChangeFunction1)],
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 3,
      backgroundColor: val1 ? Colors.grey[800] : Colors.white,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: val1 ? Colors.white : Colors.black,
        ),
      ),
      title: Text(
        "Settings",
        style: GoogleFonts.lato(
            textStyle: const TextStyle(fontSize: 20),
            color: val1 ? Colors.white : Colors.black),
      ),
    );
  }

  Widget _customSwitch(String text, bool val, Function onChangeMethod) {
    return Column(
      children: [
        CupertinoSwitch(
          trackColor: Colors.grey,
          activeColor: primaryClr,
          value: val,
          onChanged: (newValuew) {
            onChangeMethod(newValuew);
          },
        ),
        Text(
          text,
          style: GoogleFonts.lato(
              fontSize: 20, color: val1 ? Colors.white : Colors.black),
        ),
      ],
    );
  }
}
