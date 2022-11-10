import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:karma_app/controller/api.dart';
import 'package:karma_app/controller/con_event.dart';
import 'package:karma_app/model/model_event.dart';
import 'package:karma_app/view/bottom_view.dart';
import 'package:karma_app/view/view_detail.dart';
import 'package:karma_app/widget/router.dart';

class HomeView extends StatefulWidget {
  const HomeView({key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<Event>>? getSlider;
  List<Event> listSlider = [];
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

  @override
  void initState() {
    super.initState();
    getSlider = fetchEvent(listSlider);
  }

  //Pull to refresh: get updated list of events 
  Future refresh() async {
    setState(() => listSlider.clear());
      setState(() {
        getSlider = fetchEvent(listSlider);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.handshake_outlined, color: Colors.white),
          onPressed: () {
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomView()), (Route<dynamic> route) => false);
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder<List<Event>>(
          future: getSlider,
          builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //Display data
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                      title: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                              child: Image.network(listSlider[index].imageUrl,
                                  height: 200, fit: BoxFit.fill),
                            ),
                            ListTile(
                              leading: Column(
                                children: <Widget>[
                                  Text(
                                    DateTime.parse(listSlider[index].startDate)
                                        .day
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.teal[300],
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    months[(DateTime.parse(
                                            listSlider[index].startDate)
                                        .month)-1],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              title: Text(
                                listSlider[index].name,
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                listSlider[index].organization,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                const SizedBox(width: 70),
                                const Icon(
                                  Icons.location_city,
                                  color: Color.fromARGB(255, 237, 137, 170),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  listSlider[index].venue,
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const SizedBox(width: 70),
                                Icon(
                                  Icons.local_attraction_rounded,
                                  color: Colors.amber[500],
                                ),
                                const SizedBox(width: 10),
                                listSlider[index].limitRegistration == 0
                                    ? Text('Open registration!')
                                    : Text(
                                        '${(listSlider[index].limitRegistration - listSlider[index].currentParticipants).toString()} spot(s) left',
                                      )
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      onTap: () async {
                        pushPage(
                            context,
                            DetailView(
                              eventID: listSlider[index].id,
                              status: listSlider[index].status,
                            ));
                      });
                },
              );
            } else {
              //Return a circular progress indicator.
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}
