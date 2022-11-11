import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma_app/controller/con_mission.dart';
import 'package:karma_app/model/model_event.dart';
import 'package:karma_app/view/bottom_view.dart';
import 'package:karma_app/view/custom_error.dart';
import 'package:karma_app/view/view_upcoming_detail.dart';
import 'package:karma_app/widget/router.dart';
import 'package:karma_app/widget/shared_pref.dart';

//Upcoming Mission
class MyUpcomingMission extends StatefulWidget {
  const MyUpcomingMission({key});

  @override
  State<MyUpcomingMission> createState() => _MyUpcomingMissionState();
}

class _MyUpcomingMissionState extends State<MyUpcomingMission>
    with TickerProviderStateMixin {
  late TabController _tabController;

  Future<List<Event>>? getMission;
  List<Event> listMission = [];
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  String id = '', name = '', email = '', photo = '';

  @override
  void initState() {
    super.initState();
    getMission = fetchUpcomingMission(listMission, id);
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

  //Pull to refresh: get updated list of missions
  Future refresh() async {
    setState(() => listMission.clear());
    setState(() {
      getMission = fetchUpcomingMission(listMission, id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Upcoming Missions'),
            automaticallyImplyLeading: false),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: Container(
              child: FutureBuilder(
                  future: getMission,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Event>> snapshot) {
                    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                      return CustomError(errorDetails: errorDetails);
                    };
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
                                          Text(
                                            DateTime.parse(listMission[index]
                                                    .startDate)
                                                .day
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.teal[300],
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            months[(DateTime.parse(
                                                        listMission[index]
                                                            .startDate)
                                                    .month) -
                                                1],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      title: Text(
                                        listMission[index].name,
                                        style: const TextStyle(
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
                                        const SizedBox(width: 70),
                                        const Icon(
                                          Icons.location_city,
                                          color: Color.fromARGB(
                                              255, 237, 137, 170),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          listMission[index].venue,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const SizedBox(width: 70),
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber[500],
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                            '${listMission[index].points.toString()} Karma points'),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
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
                      return const Center(child: CircularProgressIndicator());
                    }
                  })),
        ));
  }
}