// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_badge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Badge _$BadgeFromJson(Map<String, dynamic> json) => Badge(
      id: json['id'] as int,
      badge_name: json['badge_name'] as String,
      badge_description: json['badge_description'] as String,
      badge_img: json['badge_img'] as String,
      badge_key: json['badge_key'] as int,
    );

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      'id': instance.id,
      'badge_key': instance.badge_key,
      'badge_name': instance.badge_name,
      'badge_description': instance.badge_description,
      'badge_img': instance.badge_img,
    };
