import 'package:dio/dio.dart';
import 'package:karma_app/models/mission.dart';
import 'package:karma_app/controller/api.dart';

Future<List<Mission>> getMission(List<Mission> q) async {
  var request = await Dio().get(Api.baseUrl + Api.api + Api.mission);

  for (Map<String, dynamic> mission in request.data) {
    q.add(Mission(
      id: mission['id'],
      userID: mission['userID'],
      eventID: mission['eventID'],
      createdAt: mission['createdAt'],
      eventName: mission['eventName'],
    ));
  }
  return q;
}
