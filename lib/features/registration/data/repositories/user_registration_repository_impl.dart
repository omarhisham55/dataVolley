import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:data_volley_match/features/registration/data/datasources/user_registration_datasource.dart';
import 'package:data_volley_match/features/registration/domain/repositories/user_registration_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRegistrationRepositoryImpl implements UserRegistrationRepository {
  final UserRegistrationDatasource userRegistrationDatasource;

  UserRegistrationRepositoryImpl({required this.userRegistrationDatasource});

  @override
  Future<Either<Failure, User?>> createEmailAccount({
    required String email,
    required String password,
  }) async {
    try {
      return Right(
        await userRegistrationDatasource.createEmailAccount(
          email: email,
          password: password,
        ),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User?>> createGoogleAccount() async {
    try {
      return Right(
        await userRegistrationDatasource.createGoogleAccount(),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User?>> loginAccount(
      {required String email, required String password}) async {
    try {
      return Right(
        await userRegistrationDatasource.loginAccount(
          email: email,
          password: password,
        ),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
