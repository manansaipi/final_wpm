import 'package:final_wpm/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr,
        ),
        child: Center(
            child: Text(
          label,
          style: TextStyle(color: Colors.white),
        )),
        // child: Text(
        //   label,
        // style: TextStyle(color: Colors.white),
        // ),
      ),
    );
  }
}

class MyCircleButton extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const MyCircleButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: primaryClr,
        ),
        child: Center(
            child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 25),
        )),
        // child: Text(
        //   label,
        // style: TextStyle(color: Colors.white),
        // ),
      ),
    );
  }
}
