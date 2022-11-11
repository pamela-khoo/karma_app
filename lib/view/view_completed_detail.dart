import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:karma_app/controller/api.dart';
import 'package:karma_app/controller/con_detail.dart';
import 'package:karma_app/controller/con_save_mission.dart';
import 'package:karma_app/model/model_event.dart';
import 'package:karma_app/widget/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CompletedDetailView extends StatefulWidget {
  int eventID;
  int status;

  CompletedDetailView({required this.eventID, required this.status});

  @override
  _CompletedDetailViewState createState() => _CompletedDetailViewState();
}

class _CompletedDetailViewState extends State<CompletedDetailView> {
  Future<List<Event>>? getDetail;
  List<Event> listDetail = [];
  String id = '', name = '', email = '', checkMission = "0";
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
        title: const Text('Detail Page'),
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
                              onTap: () => launch(listDetail[index].orgUrl)
                            ),

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

                                listDetail[index].startDate == listDetail[index].endDate
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
      backgroundColor: Colors.white, // Background Color
),
                                          child: const Text('View on Google Maps'),
                                         onPressed: () => launch(ApiConstant().mapSearch+listDetail[index].organization)
                                        ),
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
