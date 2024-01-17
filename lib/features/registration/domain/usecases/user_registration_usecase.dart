import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:data_volley_match/core/shared/usecases.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:data_volley_match/features/registration/domain/repositories/user_registration_repository.dart';

class UserEmailRegistrationUsecase
    implements FutureUseCase<User?, List<String>> {
  final UserRegistrationRepository userRegistrationRepository;

  UserEmailRegistrationUsecase({required this.userRegistrationRepository});
  @override
  Future<Either<Failure, User?>> call(List<String> param) =>
      userRegistrationRepository.createEmailAccount(
        email: param[0],
        password: param[1],
      );
}

class UserGoogleRegistrationUsecase implements FutureUseCase<User?, NoParam> {
  final UserRegistrationRepository userRegistrationRepository;

  UserGoogleRegistrationUsecase({required this.userRegistrationRepository});
  @override
  Future<Either<Failure, User?>> call(NoParam param) =>
      userRegistrationRepository.createGoogleAccount();
}

class UserLoginUsecase implements FutureUseCase<User?, List<String>> {
  final UserRegistrationRepository userRegistrationRepository;

  UserLoginUsecase({required this.userRegistrationRepository});
  @override
  Future<Either<Failure, User?>> call(List<String> param) =>
      userRegistrationRepository.loginAccount(
        email: param[0],
        password: param[1],
      );
}
