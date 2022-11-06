import 'package:json_annotation/json_annotation.dart';
part 'model_badge.g.dart';

@JsonSerializable()
class Badge {
  int id, badge_key;
  String badge_name, badge_description, badge_img;

  Badge({
    required this.id,
    required this.badge_name,
    required this.badge_description,
    required this.badge_img,
    required this.badge_key,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeToJson(this);
}
