import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma_app/controller/con_mission.dart';
import 'package:karma_app/model/model_event.dart';
import 'package:karma_app/view/view_completed_detail.dart';
import 'package:karma_app/view/view_detail.dart';
import 'package:karma_app/view/view_upcoming_detail.dart';
import 'package:karma_app/widget/router.dart';
import 'package:karma_app/widget/shared_pref.dart';

class MissionView extends StatelessWidget {
  const MissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50), 
              color: Colors.greenAccent),
              tabs: [
                Tab(icon: Icon(Icons.calendar_today)),
                Tab(icon: Icon(Icons.check_circle)),
              ],
            ),
            title: const Text('My Volunteer Missions'),
          ),
          body: TabBarView(
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

//Upcoming Mission
class MyUpcomingMission extends StatefulWidget {
  const MyUpcomingMission({key});

  @override
  State<MyUpcomingMission> createState() => _MyUpcomingMissionState();
}

class _MyUpcomingMissionState extends State<MyUpcomingMission> with TickerProviderStateMixin{
  late TabController _tabController;

  Future<List<Event>>? getMission;
  List<Event> listMission = [];

  String id = '', name = '', email = '', photo = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    prefLoad().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        getMission = fetchUpcomingMission(listMission, id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Upcoming Missions'),
            automaticallyImplyLeading: false),
        body: Center(
          child: Container(
              child: FutureBuilder(
                  future: getMission,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Event>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, int index) {
                          return ListTile(
                              title: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 15, 15, 0),
                                      child: Image.network(
                                          listMission[index].imageUrl,
                                          height: 200,
                                          fit: BoxFit.fill),
                                    ),
                                    ListTile(
                                      leading: Column(
                                        children: <Widget>[
                                          //TODO: Get date from DB
                                          Text(
                                            "17",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "SEP",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      title: Text(
                                        listMission[index].name,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        listMission[index].organization,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 70),
                                        Icon(Icons.location_city),
                                        SizedBox(width: 10),
                                        Text(
                                          listMission[index].venue,
                                          style: TextStyle(),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 70),
                                        Icon(Icons.star),
                                        SizedBox(width: 10),
                                        Text(
                                          listMission[index]
                                              .limitRegistration
                                              .toString(),
                                          style: TextStyle(),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                pushPage(
                                    context,
                                    UpcomingDetailView(
                                      eventID: listMission[index].id,
                                      status: listMission[index].status,
                                    ));
                              });
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
        ));
  }
}


//Completed Mission
class MyCompletedMission extends StatefulWidget {
  const MyCompletedMission({key});

  @override
  State<MyCompletedMission> createState() => _MyCompletedMissionState();
}

class _MyCompletedMissionState extends State<MyCompletedMission> with TickerProviderStateMixin{
  late TabController _tabController;

  Future<List<Event>>? getMission;
  List<Event> listMission = [];

  String id = '', name = '', email = '', photo = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    prefLoad().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        getMission = fetchCompletedMission(listMission, id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Completed Missions'),
            automaticallyImplyLeading: false),
        body: Center(
          child: Container(
              child: FutureBuilder(
                  future: getMission,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Event>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, int index) {
                          return ListTile(
                              title: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 15, 15, 0),
                                      child: Image.network(
                                          listMission[index].imageUrl,
                                          height: 200,
                                          fit: BoxFit.fill),
                                    ),
                                    ListTile(
                                      leading: Column(
                                        children: <Widget>[
                                          //TODO: Get date from DB
                                          Text(
                                            "17",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "SEP",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      title: Text(
                                        listMission[index].name,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        listMission[index].organization,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 70),
                                        Icon(Icons.location_city),
                                        SizedBox(width: 10),
                                        Text(
                                          listMission[index].venue,
                                          style: TextStyle(),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 70),
                                        Icon(Icons.star),
                                        SizedBox(width: 10),
                                        Text(
                                          listMission[index]
                                              .limitRegistration
                                              .toString(),
                                          style: TextStyle(),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                pushPage(
                                    context,
                                    CompletedDetailView(
                                      eventID: listMission[index].id,
                                      status: listMission[index].status,
                                    ));
                              });
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
        ));
  }
}

