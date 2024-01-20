import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:data_volley_match/features/match_layout/data/datasources/team/team_datasource.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';
import 'package:data_volley_match/features/match_layout/domain/repositories/team/team_repository.dart';

class TeamRepositoryImpl implements TeamRepository {
  final TeamDatasource teamDatasource;

  TeamRepositoryImpl({required this.teamDatasource});

  @override
  Future<Either<Failure, bool>> saveTeam({
    required TeamModel team,
  }) async {
    try {
      return Right(await teamDatasource.saveTeam(team: team));
    } catch (error) {
      return Left(ServerFailure(error: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTeams({
    required TeamModel team,
  }) async {
    try {
      return Right(await teamDatasource.deleteTeam(team: team));
    } catch (error) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> editTeams({required TeamModel team}) async {
    try {
      return Right(await teamDatasource.editTeam(team: team));
    } catch (error) {
      return Left(ServerFailure(error: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, List<TeamModel>>>> getTeams() async {
    try {
      return Right(await teamDatasource.getTeams());
    } catch (error) {
      return Left(ServerFailure());
    }
  }
}
