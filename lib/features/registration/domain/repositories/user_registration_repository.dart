import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRegistrationRepository {
  Future<Either<Failure, User?>> createEmailAccount({
    required String email,
    required String password,
  });
  Future<Either<Failure, User?>> loginAccount({
    required String email,
    required String password,
  });
  Future<Either<Failure, User?>> createGoogleAccount();
}
