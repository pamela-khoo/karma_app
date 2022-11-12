import 'package:json_annotation/json_annotation.dart';
part 'model_leaderboard.g.dart';

@JsonSerializable()
class Leaderboard {
  int id, points;
  String name;

  Leaderboard({
    required this.id, 
    required this.name,
    required this.points,
    });

  factory Leaderboard.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardToJson(this);
}
