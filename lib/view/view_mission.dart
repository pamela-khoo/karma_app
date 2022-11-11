import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma_app/view/bottom_view.dart';
import 'package:karma_app/view/view_completed_mission.dart';
import 'package:karma_app/view/view_upcoming_mission.dart';
import 'package:karma_app/widget/router.dart';

class MissionView extends StatelessWidget {
  const MissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.teal[800]),
              tabs: [
                Tab(icon: Icon(Icons.today_rounded)),
                Tab(icon: Icon(Icons.task_alt)),
              ],
            ),
            title: const Text('My Volunteer Missions'),
            leading: IconButton(
              icon: const Icon(Icons.handshake_outlined, color: Colors.white),
              onPressed: () {
                pushAndRemove(context, BottomView());
              },
            ),
          ),
          body: const TabBarView(
            children: [
              Center(
                child: MyUpcomingMission(),
              ),
              Center(
                child: MyCompletedMission(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

