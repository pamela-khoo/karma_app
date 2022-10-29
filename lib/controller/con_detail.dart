//Future is n object representing a delayed computation.
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:karma_app/controller/api.dart';
import 'package:karma_app/model/model_event.dart';

Future<List<Event>> fetchDetail(List<Event> fetch, int id) async {
  print(
      "BASE URL ${ApiConstant().baseUrl + ApiConstant().api + ApiConstant().eventById + id.toString()}"); //JSON of event details by eventID
  var request = await Dio().get(ApiConstant().baseUrl +
      ApiConstant().api +
      ApiConstant().eventById +
      id.toString());

  for (Map<String, dynamic> events in request.data) {
    fetch.add(Event(
        id: events['id'],
        name: events['name'],
        startDate: events['start_date'],
        endDate: events['end_date'],
        startTime: events['start_time'],
        endTime: events['end_time'],
        description: events['description'],
        status: events['status'],
        venue: events['venue'],
        category: events['cat_name'],
        organization: events['org_name'],
        points: events['points'],
        imageUrl: events['image_url'],
        limitRegistration: events['limit_registration']));
  }
  return fetch;
}
