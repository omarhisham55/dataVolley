import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:data_volley_match/features/match_layout/data/datasources/image/image_datasource.dart';
import 'package:data_volley_match/features/match_layout/domain/repositories/image/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageDatasource imageDatasource;

  ImageRepositoryImpl({required this.imageDatasource});
  @override
  Future<Either<Failure, String?>> addTeamImage() async {
    try {
      return Right(await imageDatasource.addTeamImage());
    } catch (error) {
      return Left(ServerFailure(error: error.toString()));
    }
  }
}
