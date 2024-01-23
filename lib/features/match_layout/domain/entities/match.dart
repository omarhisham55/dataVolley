import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';
import 'package:equatable/equatable.dart';

class Match extends Equatable {
  final String id;
  final String level;
  final TeamModel homeTeam;
  final TeamModel awayTeam;
  final List<String> homeSetters;
  final Map<String, List<String>?>? homeTeamPosition;
  final List<String> awaySetters;
  final Map<String, List<String>?>? awayTeamPosition;
  final List<String> score;
  final String dateTime;
  final bool isFriendly;
  final bool videoExist;

  const Match({
    required this.id,
    required this.level,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeSetters,
    required this.homeTeamPosition,
    required this.awaySetters,
    required this.awayTeamPosition,
    required this.score,
    required this.dateTime,
    required this.isFriendly,
    required this.videoExist,
  });
  @override
  List<Object?> get props => [level, homeTeam, awayTeam];
}
