import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Mission {
  final String id;
  final String userID, eventID;
  final DateTime createdAt;
  final String eventName;

  Mission({
    required this.id,
    required this.userID,
    required this.eventID,
    required this.createdAt,
    required this.eventName,
  });

  factory Mission.fromJson(Map<String, dynamic> jsonData) {
    return Mission(
      id: jsonData['id'],
      userID: jsonData['userID'],
      eventID: jsonData['eventID'],
      createdAt: jsonData['createdAt'],
      eventName: jsonData['eventName'],
    );
  }
}
