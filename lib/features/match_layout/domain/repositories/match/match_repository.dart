import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:data_volley_match/features/match_layout/data/models/match_model.dart';

abstract class MatchRepository {
  Future<Either<Failure, bool>> saveMatch({required MatchModel match});
  Future<Either<Failure, Map<String, List<MatchModel>>>> getMatches();
  Future<Either<Failure, bool>> editMatch({required MatchModel match});
  Future<Either<Failure, bool>> deleteMatch({required MatchModel match});
}
