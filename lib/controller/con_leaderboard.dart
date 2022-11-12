//Future is n object representing a delayed computation.
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:karma_app/controller/api.dart';
import 'package:karma_app/model/model_leaderboard.dart';

Future<List<Leaderboard>> fetchLeaderboard(List<Leaderboard> fetch) async {
  print(
      "BASE URL ${ApiConstant().baseUrl + ApiConstant().api + ApiConstant().leaderboard}"); //JSON of leaderboard
  var request = await Dio()
      .get(ApiConstant().baseUrl + ApiConstant().api + ApiConstant().leaderboard);

  for (Map<String, dynamic> leaderBoards in request.data) {
    fetch.add(Leaderboard(
        id: leaderBoards['id'],
        name: leaderBoards['name'],
        points: leaderBoards['points'],
        ));
  }
  return fetch;
}
