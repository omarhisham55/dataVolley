import 'package:data_volley_match/features/match_layout/domain/entities/match.dart';

class MatchModel extends Match {
  const MatchModel({
    required super.id,
    required super.level,
    required super.homeTeam,
    required super.awayTeam,
    required super.homeSetters,
    required super.homeTeamPosition,
    required super.awaySetters,
    required super.awayTeamPosition,
    required super.score,
    required super.dateTime,
    super.isFriendly,
    super.videoExist,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
        id: json['id'],
        level: json['level'],
        homeTeam: json['homeTeam'],
        awayTeam: json['awayTeam'],
        homeSetters: json['homeSetters'],
        homeTeamPosition: json['homeTeamPosition'],
        awaySetters: json['awaySetters'],
        awayTeamPosition: json['awayTeamPosition'],
        score: json['score'],
        dateTime: json['dateTime'],
        isFriendly: json['isFriendly'],
        videoExist: json['videoExist'],
      );

  static Map<String, List<String>> positionSet(List<List<String>?> positions) {
    return {
      'set 1': positions[0] ?? [],
      'set 2': positions[1] ?? [],
      'set 3': positions[2] ?? [],
      'set 4': positions[3] ?? [],
      'set 5': positions[4] ?? [],
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'level': level,
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
      'homeSetters': homeSetters,
      'homeTeamPosition': homeTeamPosition,
      'awaySetters': awaySetters,
      'awayTeamPosition': awayTeamPosition,
      'score': score,
      'dateTime': dateTime,
      'isFriendly': isFriendly,
      'videoExist': videoExist,
    };
  }
}
