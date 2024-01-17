import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:data_volley_match/core/shared/usecases.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';
import 'package:data_volley_match/features/match_layout/domain/repositories/team_repository.dart';

class CreateTeamUsecase implements FutureUseCase<bool, TeamModel> {
  final TeamRepository teamRepository;

  CreateTeamUsecase({required this.teamRepository});
  @override
  Future<Either<Failure, bool>> call(TeamModel param) async {
    return await teamRepository.saveTeam(team: param);
  }
}

class GetTeamsUsecase
    implements FutureUseCase<Map<String, List<TeamModel>>, NoParam> {
  final TeamRepository teamRepository;

  GetTeamsUsecase({required this.teamRepository});
  @override
  Future<Either<Failure, Map<String, List<TeamModel>>>> call(
      NoParam param) async {
    return await teamRepository.getTeams();
  }
}
