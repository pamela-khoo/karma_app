import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma_app/controller/api.dart';
import 'package:karma_app/widget/shared_pref.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

saveMission(
    {required BuildContext context,
    required String eventID,
    required String userID,
    required int participantNo}) async {
  var data = {'event_id': eventID, 'user_id': userID, 'participant_no': participantNo};
  
  var req = await Dio()
      .post(ApiConstant().baseUrl + ApiConstant().joinMission, data: data);

  var checkMission = await Dio()
      .post(ApiConstant().baseUrl + ApiConstant().checkMission, data: data);

  if (req.data == "success") {
    await Alert(
        context: context,
        type: AlertType.success,
        onWillPopActive: true,
        title: 'See you there!',
        desc: 'This event was added to your joined missions!',
        style: AlertStyle(
            animationType: AnimationType.fromBottom,
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.black),
            descStyle: TextStyle(color: Colors.black) // TextStyle
            ), // AlertStyle buttons: [
        buttons: [
          DialogButton(
            padding: EdgeInsets.all(1),
            child: Container(
              height: 45,
              child: Center(child: Text("Okay")),
            ),
            onPressed: () {
              Navigator.pop(context);

              //Add to mission
              joinMission(checkMission.data);
            },
          )
        ]).show();
  } else {
    await Alert(
        context: context,
        type: AlertType.warning,
        onWillPopActive: true,
        title: 'Aww, see you next time',
        desc: 'This event was removed from your joined missions',
        style: AlertStyle(
            animationType: AnimationType.fromBottom,
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.black),
            descStyle: TextStyle(color: Colors.black) // TextStyle
            ), // AlertStyle buttons: [
        buttons: [
          DialogButton(
            padding: EdgeInsets.all(1),
            child: Container(
              height: 45,
              child: Center(child: Text("Okay")),
            ),
            onPressed: () {
              Navigator.pop(context);

              //Add to mission
              joinMission(checkMission.data);
              print(checkMission.data);
            },
          )
        ]).show();
  }
}
