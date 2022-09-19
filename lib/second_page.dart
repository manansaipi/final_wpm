import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("BACK"))),
      ),
    );
  }
}
