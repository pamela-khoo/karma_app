// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as int,
      name: json['name'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      description: json['description'] as String,
      status: json['status'] as int,
      venue: json['venue'] as String,
      category: json['category'] as String,
      organization: json['organization'] as String,
      points: json['points'] as int,
      imageUrl: json['imageUrl'] as String,
      limitRegistration: json['limitRegistration'] as int,
      currentParticipants: json['currentParticipants'] as int,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'points': instance.points,
      'limitRegistration': instance.limitRegistration,
      'currentParticipants': instance.currentParticipants,
      'name': instance.name,
      'description': instance.description,
      'venue': instance.venue,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'organization': instance.organization,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
