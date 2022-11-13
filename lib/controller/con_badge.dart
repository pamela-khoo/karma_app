// //Future is n object representing a delayed computation.
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:karma_app/controller/api.dart';
import 'package:karma_app/model/model_badge.dart';

saveBadges({required String userID}) async {
  var data = {'user_id': userID};
  var req = await Dio()
      .post(ApiConstant().baseUrl + ApiConstant().points, data: data);
      print(
      "BASE URL ${ApiConstant().baseUrl + ApiConstant().points}"); 
}
