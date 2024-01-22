import 'package:data_volley_match/features/match_layout/data/datasources/match/match_datasource.dart';
import 'package:data_volley_match/features/match_layout/data/datasources/team/team_datasource.dart';
import 'package:data_volley_match/features/match_layout/data/repositories/match/match_repository_impl.dart';
import 'package:data_volley_match/features/match_layout/data/repositories/team/team_repository_impl.dart';
import 'package:data_volley_match/features/match_layout/domain/repositories/match/match_repository.dart';
import 'package:data_volley_match/features/match_layout/domain/repositories/team/team_repository.dart';
import 'package:data_volley_match/features/match_layout/domain/usecases/match/match_usecase.dart';
import 'package:data_volley_match/features/match_layout/domain/usecases/team/team_usecases.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:data_volley_match/injection.dart';

Future<void> matchInit() async {
  injection.registerFactory(
    () => MatchLayoutCubit(
      createTeamUsecase: injection(),
      getTeamsUsecase: injection(),
      editTeamUsecase: injection(),
      deleteTeamsUsecase: injection(),
      imageUsecase: injection(),
      deleteMatchUsecase: injection(),
      editMatchUsecase: injection(),
      getMatchesUsecase: injection(),
      saveMatchUsecase: injection(),
    ),
  );

  injection.registerLazySingleton<TeamRepository>(
    () => TeamRepositoryImpl(teamDatasource: injection()),
  );
  injection.registerLazySingleton<TeamDatasource>(
    () => TeamDatasourceImpl(firestoreConsumer: injection()),
  );
  injection.registerLazySingleton(
    () => CreateTeamUsecase(teamRepository: injection()),
  );
  injection.registerLazySingleton(
    () => GetTeamsUsecase(teamRepository: injection()),
  );
  injection.registerLazySingleton(
    () => EditTeamUsecase(teamRepository: injection()),
  );
  injection.registerLazySingleton(
    () => DeleteTeamUsecase(teamRepository: injection()),
  );
  injection.registerLazySingleton<MatchRepository>(
    () => MatchRepositoryImpl(matchDatasource: injection()),
  );
  injection.registerLazySingleton<MatchDatasource>(
    () => MatchDatasourceImpl(matchFirestoreConsumer: injection()),
  );
  injection.registerLazySingleton(
    () => SaveMatchUsecase(matchRepository: injection()),
  );
  injection.registerLazySingleton(
    () => GetMatchesUsecase(matchRepository: injection()),
  );
  injection.registerLazySingleton(
    () => EditMatchUsecase(matchRepository: injection()),
  );
  injection.registerLazySingleton(
    () => DeleteMatchUsecase(matchRepository: injection()),
  );
}
