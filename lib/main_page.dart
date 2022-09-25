import 'package:final_wpm/ui/setting_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "Final WPM",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                //Profile Image
                // CircleAvatar(backgroundImage: AssetImage("image/profile.png"),),
                IconButton(
                    // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    onPressed: () {
                      // go to secondpage
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SettingPage();
                      }));
                    },
                    icon: Icon(Icons.settings)),
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(Icons.settings),
                // )
              ],
              //Color Degradation
              // flexibleSpace: Container(
              //   decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //           colors: [Colors.white24, Colors.lightBlue],
              //           begin: Alignment.bottomRight,
              //           end: Alignment.topLeft)),
              // ),
              bottom: TabBar(
                //Scrollable if have many tabs
                // isScrollable: true,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    text: "Home",
                  ),
                  Tab(
                    icon: Icon(Icons.alarm),
                    text: "Alarm",
                  ),
                  Tab(
                    icon: Icon(Icons.map),
                    text: "Map",
                  ),
                  Tab(
                    icon: Icon(Icons.star),
                    text: "Favorite",
                  )
                ],
              ),
              elevation: 5,
              titleSpacing: 5,
            ),
            body: TabBarView(
              children: [
                buildPage("Home"),
                buildPage("Alarm"),
                buildPage("Favorite"),
                buildPage("Settings"),
              ],
            )),
      ),
    );
  }

  Widget buildPage(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      );
}