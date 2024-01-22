import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:data_volley_match/core/shared/usecases.dart';
import 'package:data_volley_match/features/match_layout/data/models/match_model.dart';
import 'package:data_volley_match/features/match_layout/domain/repositories/match/match_repository.dart';

class SaveMatchUsecase implements FutureUseCase<bool, MatchModel> {
  final MatchRepository matchRepository;

  SaveMatchUsecase({required this.matchRepository});
  @override
  Future<Either<Failure, bool>> call(MatchModel param) async {
    return await matchRepository.saveMatch(match: param);
  }
}

class EditMatchUsecase implements FutureUseCase<bool, MatchModel> {
  final MatchRepository matchRepository;

  EditMatchUsecase({required this.matchRepository});
  @override
  Future<Either<Failure, bool>> call(MatchModel param) async {
    return await matchRepository.editMatch(match: param);
  }
}

class DeleteMatchUsecase implements FutureUseCase<bool, MatchModel> {
  final MatchRepository matchRepository;

  DeleteMatchUsecase({required this.matchRepository});
  @override
  Future<Either<Failure, bool>> call(MatchModel param) async {
    return await matchRepository.deleteMatch(match: param);
  }
}

class GetMatchesUsecase
    implements FutureUseCase<Map<String, List<MatchModel>>, NoParam> {
  final MatchRepository matchRepository;

  GetMatchesUsecase({required this.matchRepository});
  @override
  Future<Either<Failure, Map<String, List<MatchModel>>>> call(
      NoParam param) async {
    return await matchRepository.getMatches();
  }
}
