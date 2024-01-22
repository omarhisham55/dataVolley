import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:data_volley_match/features/match_layout/data/datasources/match/match_datasource.dart';
import 'package:data_volley_match/features/match_layout/data/models/match_model.dart';
import 'package:data_volley_match/features/match_layout/domain/repositories/match/match_repository.dart';

class MatchRepositoryImpl implements MatchRepository {
  final MatchDatasource matchDatasource;

  MatchRepositoryImpl({required this.matchDatasource});
  @override
  Future<Either<Failure, bool>> deleteMatch({required MatchModel match}) async {
    try {
      return Right(await matchDatasource.deleteMatch(match: match));
    } catch (error) {
      return Left(ServerFailure(error: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> editMatch({required MatchModel match}) async {
    try {
      return Right(await matchDatasource.editMatch(match: match));
    } catch (error) {
      return Left(ServerFailure(error: error.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, List<MatchModel>>>> getMatches() async {
    try {
      return Right(await matchDatasource.getMatches());
    } catch (error) {
      return Left(ServerFailure(error: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveMatch({required MatchModel match}) async {
    try {
      return Right(await matchDatasource.saveMatch(match: match));
    } catch (error) {
      return Left(ServerFailure(error: error.toString()));
    }
  }
}
