import 'package:data_volley_match/features/registration/data/datasources/user_registration_datasource.dart';
import 'package:data_volley_match/features/registration/data/repositories/user_registration_repository_impl.dart';
import 'package:data_volley_match/features/registration/domain/repositories/user_registration_repository.dart';
import 'package:data_volley_match/features/registration/domain/usecases/user_registration_usecase.dart';
import 'package:data_volley_match/features/registration/presentation/cubit/registration_cubit.dart';
import 'package:data_volley_match/injection.dart';

Future<void> registrationInit() async {
  injection.registerFactory(
    () => RegistrationCubit(
      googleRegistrationUsecase: injection(),
      userEmailRegistrationUsecase: injection(),
      userLoginusecase: injection(),
    ),
  );

  injection.registerLazySingleton<UserRegistrationDatasource>(
    () => UserRegistrationDatasourceImpl(
      firebaseConsumer: injection(),
    ),
  );
  injection.registerLazySingleton<UserRegistrationRepository>(
    () => UserRegistrationRepositoryImpl(
      userRegistrationDatasource: injection(),
    ),
  );
  injection.registerLazySingleton(
    () => UserEmailRegistrationUsecase(
      userRegistrationRepository: injection(),
    ),
  );
  injection.registerLazySingleton(
    () => UserGoogleRegistrationUsecase(
      userRegistrationRepository: injection(),
    ),
  );
  injection.registerLazySingleton(
    () => UserLoginUsecase(
      userRegistrationRepository: injection(),
    ),
  );
}
