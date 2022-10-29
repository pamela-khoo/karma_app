import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma_app/controller/con_mission.dart';
import 'package:karma_app/model/model_event.dart';
import 'package:karma_app/view/view_detail.dart';
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
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
            title: const Text('My Volunteer Missions'),
          ),
          body: TabBarView(
            children: [
              Center(
                child: MyStatefulWidget(),
              ),
              Center(
                child: MyStatefulWidget2(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Upcoming
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> with TickerProviderStateMixin{
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
        getMission = fetchMission(listMission, id);
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
                                    DetailView(
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


//TODO: Completed 
class MyStatefulWidget2 extends StatefulWidget {
  const MyStatefulWidget2({key});

  @override
  State<MyStatefulWidget2> createState() => _MyStatefulWidgetState2();
}

class _MyStatefulWidgetState2 extends State<MyStatefulWidget2> with TickerProviderStateMixin{
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
        getMission = fetchMission(listMission, id);
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
                                    DetailView(
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

