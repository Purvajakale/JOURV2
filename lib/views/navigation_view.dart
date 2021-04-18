import 'package:flutter/material.dart';
import 'package:jourv2/views/new_works/schedule_view.dart';
import 'package:jourv2/views/posts.dart';
import 'package:jourv2/views/secondroute.dart';
import 'pages.dart';
import 'home_view.dart';
import 'package:jourv2/models/work.dart';
import 'profile_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final newWork = new details(
      null,
      null,
      null,
      null,
      null,
      null,
    );

    final List<Widget> _children = [
      HomeView(),
      // ProfileView(),
      UploadPage(),
      HomePage()
      // SchedulePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('JOUR'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(4.0),
          //   child: IconButton(
          //     icon: Icon(
          //       Icons.add,
          //       size: 40,
          //     ),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => NewScheduleLog(
          //                   detail: newWork,
          //                 )),
          //       );
          //     },
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              icon: Icon(
                Icons.account_circle,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileView()),
                );
              },
            ),
          ),
        ],
      ),
      body: _children[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewScheduleLog(
                            detail: newWork,
                          )),
                );
              },
            )
          : null,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        onTap: onTabTapped,
        color: Colors.blueAccent,
        animationCurve: Curves.easeIn,
        height: 60,
        // items: [
        //   BottomNavigationBarItem(
        //     icon: new Icon(Icons.home),
        //     title: new Text('Home'),
        //   ),
        //   BottomNavigationBarItem(
        //     icon: new Icon(Icons.account_circle),
        //     title: new Text('Profile'),
        //   ),
        //   BottomNavigationBarItem(
        //     icon: new Icon(Icons.event),
        //     title: new Text('Schedule'),
        //   ),
        // ],
        items: [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          // Icon(
          //   Icons.account_circle,
          //   size: 30,
          //   color: Colors.white,
          // ),
          Icon(
            Icons.camera,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.post_add,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
