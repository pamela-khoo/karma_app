import 'package:json_annotation/json_annotation.dart';
import 'package:karma_app/model/model_badge.dart';
part 'model_profile.g.dart';

@JsonSerializable()
class Profile {
  int id, missionTotal, points;
  List<Badge> badge, badgeAll;

  Profile({
    required this.id, 
    required this.missionTotal, 
    required this.points,
    required this.badge, 
    required this.badgeAll
    });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
