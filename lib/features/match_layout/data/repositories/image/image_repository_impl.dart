import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:data_volley_match/features/match_layout/data/datasources/image/image_datasource.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';
import 'package:data_volley_match/features/match_layout/domain/repositories/image/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageDatasource imageDatasource;

  ImageRepositoryImpl({required this.imageDatasource});
  @override
  Future<Either<Failure, void>> addTeamImage({required TeamModel team}) async {
    try {
      return Right(await imageDatasource.addTeamImage(team: team));
    } catch (error) {
      return Left(ServerFailure(error: error.toString()));
    }
  }
}
