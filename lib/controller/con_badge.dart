//Future is n object representing a delayed computation.
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:karma_app/controller/api.dart';
import 'package:karma_app/model/model_badge.dart';

Future<List<Badge>> fetchBadge(List<Badge> fetch) async {
  print(
      "BASE URL ${ApiConstant().baseUrl + ApiConstant().api + ApiConstant().badge}"); 
  var request = await Dio()
      .get(ApiConstant().baseUrl + ApiConstant().api + ApiConstant().badge);

  for (Map<String, dynamic> badge in request.data) {
    fetch.add(Badge(
        id: badge['id'],
        badge_name: badge['badge_name'],
        badge_description: badge['badge_description'],
        badge_status: badge['badge_status'],
        badge_img: badge['badge_img'],
        badge_key: badge['badge_key']));
  }
  return fetch;
}
