// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['id'] as int,
      missionTotal: json['missionTotal'] as int,
      points: json['points'] as int,
      badge: (json['badge'] as List<dynamic>)
          .map((e) => Badge.fromJson(e as Map<String, dynamic>))
          .toList(),
      badgeAll: (json['badgeAll'] as List<dynamic>)
          .map((e) => Badge.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'missionTotal': instance.missionTotal,
      'points': instance.points,
      'badge': instance.badge,
      'badgeAll': instance.badgeAll,
    };
