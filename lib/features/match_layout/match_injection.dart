import 'package:data_volley_match/features/match_layout/data/datasources/team_datasource.dart';
import 'package:data_volley_match/features/match_layout/data/repositories/team_repository_impl.dart';
import 'package:data_volley_match/features/match_layout/domain/repositories/team_repository.dart';
import 'package:data_volley_match/features/match_layout/domain/usecases/team_usecases.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:data_volley_match/injection.dart';

Future<void> matchInit() async {
  injection.registerFactory(
    () => MatchLayoutCubit(
      createTeamUsecase: injection(),
      getTeamsUsecase: injection(),
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
}
