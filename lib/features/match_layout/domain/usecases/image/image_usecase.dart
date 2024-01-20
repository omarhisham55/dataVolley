import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:data_volley_match/core/shared/usecases.dart';
import 'package:data_volley_match/features/match_layout/domain/repositories/image/image_repository.dart';

class ImageUsecase implements FutureUseCase<String?, NoParam> {
  final ImageRepository imageRepository;

  ImageUsecase({required this.imageRepository});
  @override
  Future<Either<Failure, String?>> call(NoParam param) async {
    return await imageRepository.addTeamImage();
  }
}
