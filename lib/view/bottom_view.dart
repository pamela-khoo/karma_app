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
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: whenTap,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.blueAccent,
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.home,
                color: Colors.lightBlueAccent,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.leaderboard_outlined,
                color: Colors.blueAccent,
              ),
              label: 'Missions',
              activeIcon: Icon(
                Icons.leaderboard,
                color: Colors.lightBlueAccent,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.blueAccent,
              ),
              label: 'Profile',
              activeIcon: Icon(
                Icons.account_circle,
                color: Colors.lightBlueAccent,
              ))
        ],
      ),
      backgroundColor: Colors.red,
      body: body[currentIndex],
    );
  }

  void whenTap(int tap) {
    setState(() {
      currentIndex = tap;
    });
  }
}
