import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:karma_app/controller/api.dart';
import 'package:karma_app/controller/con_detail.dart';
import 'package:karma_app/controller/con_save_mission.dart';
import 'package:karma_app/model/model_event.dart';
import 'package:karma_app/widget/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailView extends StatefulWidget {
  int eventID;
  int status;

  DetailView({required this.eventID, required this.status});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
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
        title: new Text('Detail Page'),
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Icon(Icons.arrow_back)),
      ),
      body: Container(
          child: FutureBuilder(
        future: getDetail,
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            child: new Text(
                              'EVENT DETAILS',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                              textAlign: TextAlign.center,
                            ),
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          ),
                          Padding(
                            //`widget` is the current configuration. A State object's configuration
                            //is the corresponding StatefulWidget instance.
                            child: Image.network(listDetail[index].imageUrl),
                            padding: EdgeInsets.all(12.0),
                          ),
                          Padding(
                            child: new Text(
                              'NAME : ${listDetail[index].name}',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            padding: EdgeInsets.all(20.0),
                          ),
                          Padding(
                            child: new Text(
                              'DESCRIPTION : ${listDetail[index].description}',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            padding: EdgeInsets.all(20.0),
                          ),
                          Padding(
                            child: new Text(
                              'VENUE : ${listDetail[index].venue}',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            padding: EdgeInsets.all(20.0),
                          ),
                          Padding(
                            child: new Text(
                              'ORGANIZATION : ${listDetail[index].organization}',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            padding: EdgeInsets.all(20.0),
                          ),
                          Padding(
                            child: new Text(
                              'DATE : ${listDetail[index].startDate} to ${listDetail[index].endDate}',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            padding: EdgeInsets.all(20.0),
                          ),
                          Padding(
                            child: new Text(
                              'TIME : ${listDetail[index].startTime}',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            padding: EdgeInsets.all(20.0),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                // Respond to button press
                                await showDialog(
                                  context: context,
                                  builder: (myMission) => FutureProgressDialog(
                                    saveMission(
                                        context: myMission,
                                        eventID: widget.eventID.toString(),
                                        userID: id),
                                  ),
                                ).then((value) async {
                                  preferences =
                                      await SharedPreferences.getInstance();
                                  dynamic fav = preferences.get('saveMission');
                                  setState(() {
                                    checkMission = fav;
                                  });
                                });
                              },
                              child: checkMission == "already"
                                  ? Text('Already Joined Event')
                                  : Text('Join Event')),
                        ],
                      );
                    })
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}
