import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma_app/main.dart';
import 'package:karma_app/view/view_home.dart';
import 'package:karma_app/view/view_mission.dart';
import 'package:karma_app/view/view_profile.dart';

class BottomView extends StatefulWidget {
  @override
  _BottomViewState createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  int currentIndex = 0;

  List<Widget> body = [HomeView(), MissionView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
         onWillPop: () async{
           return false;
         },
    child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: whenTap,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.teal[300],
              ),
              label: 'Home',
              activeIcon: const Icon(
                Icons.home,
                color: Colors.teal,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.leaderboard_outlined,
                color: Colors.teal[300],
              ),
              label: 'Missions',
              activeIcon: const Icon(
                Icons.leaderboard,
                color: Colors.teal,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.teal[300],
              ),
              label: 'Profile',
              activeIcon: const Icon(
                Icons.account_circle,
                color: Colors.teal,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: body[currentIndex],
    )
    );
  }

  void whenTap(int tap) {
    setState(() {
      currentIndex = tap;
    });
  }
  
}
