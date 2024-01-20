import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';

abstract class ImageRepository {
  Future<Either<Failure, String?>> addTeamImage({required TeamModel team});
}
