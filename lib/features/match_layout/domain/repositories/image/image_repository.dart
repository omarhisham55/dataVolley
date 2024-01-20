import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';

abstract class ImageRepository {
  Future<Either<Failure, String?>> addTeamImage();
}
