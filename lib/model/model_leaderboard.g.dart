// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_leaderboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leaderboard _$LeaderboardFromJson(Map<String, dynamic> json) => Leaderboard(
      id: json['id'] as int,
      name: json['name'] as String,
      points: json['points'] as int,
    );

Map<String, dynamic> _$LeaderboardToJson(Leaderboard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'points': instance.points,
      'name': instance.name,
    };
