import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';

abstract class TeamRepository {
  Future<Either<Failure, bool>> saveTeam({required TeamModel team});
  Future<Either<Failure, Map<String, List<TeamModel>>>> getTeams();
  Future<Either<Failure, dynamic>> editTeams();
  Future<Either<Failure, dynamic>> deleteTeams();
}
