import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:karma_app/controller/api.dart';
import 'package:karma_app/controller/con_detail.dart';
import 'package:karma_app/controller/con_save_mission.dart';
import 'package:karma_app/model/model_event.dart';
import 'package:karma_app/view/custom_error.dart';
import 'package:karma_app/widget/shared_pref.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UpcomingDetailView extends StatefulWidget {
  int eventID;
  int status;

  UpcomingDetailView({required this.eventID, required this.status});

  @override
  _UpcomingDetailViewState createState() => _UpcomingDetailViewState();
}

class _UpcomingDetailViewState extends State<UpcomingDetailView> {
  Future<List<Event>>? getDetail;
  List<Event> listDetail = [];
  
  String id = '', name = '', email = '', checkMission = "0";
  final int _itemCount = 1;

  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    getDetail = fetchDetail(listDetail, widget.eventID);
    prefLoad().then((value) {
      id = value[0];
      name = value[1];
      email = value[2];
      checkMissions(id);
    });
  }

  checkMissions(String userID) async {
    var data = {'event_id': widget.eventID, 'user_id': userID};
    var check = await Dio()
        .post(ApiConstant().baseUrl + ApiConstant().checkMission, data: data);
    var response = check.data;
    setState(() {
      checkMission = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Detail Page'),
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder(
        future: getDetail,
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              listDetail[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24.0),
                            ),
                          ),
                          InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  listDetail[index]
                                                      .orgImageUrl),
                                              fit: BoxFit.fill),
                                          shape: BoxShape.circle)),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          listDetail[index].organization,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          'Tap to learn more',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontStyle: FontStyle.italic,
                                            color: Color.fromRGBO(
                                                155, 155, 155, 1.0),
                                          ),
                                        ),
                                      ]),
                                ],
                              ),
                              onTap: () => launch(listDetail[index].orgUrl)),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Image.network(listDetail[index].imageUrl),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0, left: 20.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.blue[300],
                                ),
                                const SizedBox(width: 10),
                                listDetail[index].startDate ==
                                        listDetail[index].endDate
                                    ? Text(
                                        listDetail[index].startDate,
                                      )
                                    : Text(
                                        '${listDetail[index].startDate} to ${listDetail[index].endDate}',
                                      )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0, left: 20.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time_filled_sharp,
                                  color: Colors.indigo[300],
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${listDetail[index].startTime} to ${listDetail[index].endTime}',
                                  style: TextStyle(),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0, left: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.deepOrange[300],
                                ),
                                SizedBox(width: 10),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        listDetail[index].venue,
                                      ),
                                      ElevatedButton(
                                          style: TextButton.styleFrom(
                                            primary: Colors.blue,
                                            backgroundColor: Colors
                                                .white, // Background Color
                                          ),
                                          child:
                                              const Text('View on Google Maps'),
                                          onPressed: () => launch(ApiConstant()
                                                  .mapSearch +
                                              listDetail[index].organization)),
                                    ]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0, left: 20.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.stars,
                                  color: Colors.yellow[700],
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Earn ${listDetail[index].points.toString()} Karma points',
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.people_outline_rounded,
                                  color: Colors.indigo[300],
                                ),
                                SizedBox(width: 10),
                                Text('${listDetail[index].participantNo} volunteer(s)')
                              ]
                            )
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.assignment,
                                  color: Colors.cyan[700],
                                ),
                                Expanded(
                                    child: Html(
                                  data: listDetail[index].description,
                                )),
                              ],
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                QrImage(
                                    data: (ApiConstant().webUrl +
                                        ApiConstant().webApi +
                                        ApiConstant().webMission +
                                        listDetail[index].id.toString()),
                                    size: 200),
                              ]),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColorDark,
                                        shadowColor: Colors.tealAccent,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        minimumSize: const Size(200, 50),
                                      ),
                                      onPressed: () async {
                                        // Respond to button press
                                        await showDialog(
                                          context: context,
                                          builder: (myMission) =>
                                              FutureProgressDialog(
                                            saveMission(
                                                context: myMission,
                                                eventID:
                                                    widget.eventID.toString(),
                                                userID: id,
                                                participantNo: _itemCount),
                                          ),
                                        ).then((value) async {
                                          preferences = await SharedPreferences
                                              .getInstance();
                                          dynamic fav =
                                              preferences.get('saveMission');
                                          setState(() {
                                            checkMission = fav;
                                          });
                                        });
                                      },
                                      child: checkMission == "already"
                                          ? const Text(
                                              'Cancel Registration',
                                              style: TextStyle(fontSize: 14),
                                            )
                                          : const Text(
                                              'Join Event',
                                              style: TextStyle(fontSize: 14),
                                            )),
                                ]),
                          )),
                        ],
                      );
                    })
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
