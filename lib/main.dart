import 'dart:developer';
import 'dart:math';

import 'package:final_wpm/login_page.dart';
import 'package:final_wpm/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

















//DRAGGABLE ITEM
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Color color1 = Colors.red;
//   Color color2 = Colors.amber;
//   Color targetColor = Colors.black;

//   bool isAccepted = false;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Draggable Item"),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Draggable<Color>(
//                   data: color1,
//                   child: SizedBox(
//                     width: 50,
//                     height: 50,
//                     child: Material(
//                       color: color1,
//                       shape: StadiumBorder(),
//                       elevation: 3,
//                     ),
//                   ),
//                   childWhenDragging: SizedBox(
//                     width: 50,
//                     height: 50,
//                     child: Material(
//                       color: Colors.grey,
//                       shape: StadiumBorder(),
//                       elevation: 0,
//                     ),
//                   ),
//                   feedback: SizedBox(
//                     width: 50,
//                     height: 50,
//                     child: Material(
//                       color: color1.withOpacity(0.7),
//                       shape: StadiumBorder(),
//                       elevation: 3,
//                     ),
//                   ),
//                 ),
//                 Draggable<Color>(
//                   data: color2,
//                   child: SizedBox(
//                     width: 50,
//                     height: 50,
//                     child: Material(
//                       color: color2,
//                       shape: StadiumBorder(),
//                       elevation: 3,
//                     ),
//                   ),
//                   childWhenDragging: SizedBox(
//                     width: 50,
//                     height: 50,
//                     child: Material(
//                       color: Colors.grey,
//                       shape: StadiumBorder(),
//                       elevation: 0,
//                     ),
//                   ),
//                   feedback: SizedBox(
//                     width: 50,
//                     height: 50,
//                     child: Material(
//                       color: color2.withOpacity(0.7),
//                       shape: StadiumBorder(),
//                       elevation: 3,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             DragTarget<Color>(
//               onWillAccept: (value) => true,
//               onAccept: (value) {
//                 isAccepted = true;
//                 targetColor = value;
//               },
//               builder: ((context, candidateData, rejectedData) {
//                 return (isAccepted)
//                     ? SizedBox(
//                         width: 150,
//                         height: 150,
//                         child: Material(
//                           color: targetColor,
//                           shape: StadiumBorder(),
//                         ),
//                       )
//                     : SizedBox(
//                         width: 150,
//                         height: 150,
//                         child: Material(
//                           color: Colors.grey,
//                           shape: StadiumBorder(),
//                         ),
//                       );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






























// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Image Widget"),
//         ),
//         body: Center(
//           child: Container(
//             color: Colors.black,
//             width: 200,
//             height: 200,
//             padding: EdgeInsets.all(3),
//             child: Image(
//               image: NetworkImage(""),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



































// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Stack and Align Widget"),
//         ),
//         body: Stack(children: [
//           //background
//           Column(
//             children: [
//               Flexible(
//                 flex: 1,
//                 child: Row(
//                   children: [
//                     Flexible(
//                         flex: 1,
//                         child: Container(
//                           color: Colors.black12,
//                         )),
//                     Flexible(
//                         flex: 1,
//                         child: Container(
//                           color: Colors.white,
//                         ))
//                   ],
//                 ),
//               ),
//               Flexible(
//                 flex: 1,
//                 child: Row(
//                   children: [
//                     Flexible(
//                         flex: 1,
//                         child: Container(
//                           color: Colors.white,
//                         )),
//                     Flexible(
//                         flex: 1,
//                         child: Container(
//                           color: Colors.black12,
//                         ))
//                   ],
//                 ),
//               )
//             ],
//           ),
//           ListView(
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.all(30),
//                     child: Text(
//                       "TThis is text written by boben orang paling ganteng dan insyallah akan suskes dunia dan akhirat aamiin ya allah",
//                       style: TextStyle(fontSize: 30),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(30),
//                     child: Text(
//                       "TThis is text written by boben orang paling ganteng dan insyallah akan suskes dunia dan akhirat aamiin ya allah",
//                       style: TextStyle(fontSize: 30),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(30),
//                     child: Text(
//                       "TThis is text written by boben orang paling ganteng dan insyallah akan suskes dunia dan akhirat aamiin ya allah",
//                       style: TextStyle(fontSize: 30),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(30),
//                     child: Text(
//                       "TThis is text written by boben orang paling ganteng dan insyallah akan suskes dunia dan akhirat aamiin ya allah",
//                       style: TextStyle(fontSize: 30),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(30),
//                     child: Text(
//                       "TThis is text written by boben orang paling ganteng dan insyallah akan suskes dunia dan akhirat aamiin ya allah",
//                       style: TextStyle(fontSize: 30),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(30),
//                     child: Text(
//                       "TThis is text written by boben orang paling ganteng dan insyallah akan suskes dunia dan akhirat aamiin ya allah",
//                       style: TextStyle(fontSize: 30),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//           //IMPORTANT
//           //MOVE BUTTON
//           Align(
//               alignment: Alignment(0, 0.8),
//               child: ElevatedButton(onPressed: null, child: Text("PressME")))
//         ]),
//       ),
//     );
//   }
// }


























// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Flexible Widget"),
//         ),
//         body: Column(
//           children: [
//             Flexible(
//               child: Row(
//                 children: [
//                   Flexible(
//                       flex: 1,
//                       child: Container(
//                         color: Colors.white,
//                       )),
//                   Flexible(
//                       flex: 1,
//                       child: Container(
//                         color: Colors.blue,
//                       )),
//                   Flexible(
//                       flex: 1,
//                       child: Container(
//                         color: Colors.yellow,
//                       )),
//                 ],
//               ),
//             ),
//             Flexible(
//                 flex: 2,
//                 child: Container(
//                   color: Colors.red,
//                 )),
//             Flexible(
//                 flex: 1,
//                 child: Container(
//                   color: Colors.blue,
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }




































// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Random random = Random();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("AnimationContainer"),
//         ),
//         body: Center(
//             child: GestureDetector(
//           onTap: (() {
//             setState(() {});
//           }),
//           child: AnimatedContainer(
//             color: Color.fromARGB(255, random.nextInt(256), random.nextInt(256),
//                 random.nextInt(256)),
//             duration: Duration(seconds: 1),
//             width: 30.0 + random.nextInt(101),
//             height: 30.0 + random.nextInt(101),
//           ),
//         )),
//       ),
//     );
//   }
// }






























// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<Widget> widgets = [];
//   int counter = 0;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Lissst and ListView"),
//         ),
//         body: ListView(
//           children: [
//             Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//               ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       widgets.add(Text(
//                         "data ke-" + counter.toString(),
//                         style: TextStyle(fontSize: 35),
//                       ));
//                       counter++;
//                     });
//                   },
//                   child: Text("Add")),
//               ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       widgets.removeLast();
//                       counter--;
//                     });
//                   },
//                   child: Text("Delete")),
//             ]),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: widgets,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
































//ANONYMOUS METHOD

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String message = "Testaaa";
//   int number = 0;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Anonymous Method"),
//         ),
//         body: Center(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(message),
//             Text(number.toString()),
//             ElevatedButton(
//                 onPressed: () {
//                   //THIS IS ANONYMOUS METHOD
//                   setState(() {
//                     message = "ben" + " " + number.toString();
//                     number++;
//                   });
//                 },
//                 child: Text("Press Me"))
//           ],
//         )),
//       ),
//     );
//   }
// }

















// Increament Button

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int number = 0;
//   void pressButton() {
//     setState(() {
//       number = number + 1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(title: Text("Increment Btn")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               number.toString(),
//               style: TextStyle(
//                 fontSize: 10 + number.toDouble(),
//               ),
//             ),
//             ElevatedButton(onPressed: pressButton, child: Text("Increase"))
//           ],
//         ),
//       ),
//     ));
//   }
// }
