//Future is n object representing a delayed computation.
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:karma_app/controller/api.dart';
import 'package:karma_app/model/model_badge.dart';
import 'package:karma_app/model/model_profile.dart';

Future<List<Profile>> fetchProfile(List<Profile> fetch, String id) async {
  print(
      "BASE URL ${ApiConstant().baseUrl + ApiConstant().api + ApiConstant().profile + id}");
  var request = await Dio()
      .get(ApiConstant().baseUrl + ApiConstant().api + ApiConstant().profile + id);

  for (Map<String, dynamic> profile in request.data) {
    List<Badge> badge = [];
    List<Badge> allBadge = [];


    for(Map<String, dynamic> badges in profile['badge']) {
      badge.add(Badge(
        id: badges['id'],
        badge_name: badges['badge_name'],
        badge_description: badges['badge_description'],
        badge_img: badges['badge_img'],
        badge_key: badges['badge_key']));
    }

    for(Map<String, dynamic> badges in profile['all_badges']) {
      allBadge.add(Badge(
        id: badges['id'],
        badge_name: badges['badge_name'],
        badge_description: badges['badge_description'],
        badge_img: badges['badge_img'],
        badge_key: badges['badge_key']));
    }

    fetch.add(Profile(
        id: profile['id'],
        missionTotal: profile['mission_total'],
        points: profile['points'],
        badge: badge,
        badgeAll: allBadge
        ));
  }
  return fetch;
}
