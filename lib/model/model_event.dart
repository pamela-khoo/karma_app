import 'package:json_annotation/json_annotation.dart';
part 'model_event.g.dart';

@JsonSerializable()
class Event {
  int id, status, points, limitRegistration;
  String name, description, venue, imageUrl, category, organization;
  String startDate, endDate, startTime, endTime;

  Event({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.status,
    required this.venue,
    required this.category,
    required this.organization,
    required this.points,
    required this.imageUrl,
    required this.limitRegistration,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
