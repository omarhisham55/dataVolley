import 'package:data_volley_match/core/firebase/firebase_consumer.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRegistrationDatasource {
  Future<User?> createEmailAccount({
    required String email,
    required String password,
  });
  Future<User?> loginAccount({
    required String email,
    required String password,
  });
  Future<User?> createGoogleAccount();
}

class UserRegistrationDatasourceImpl implements UserRegistrationDatasource {
  final FirebaseConsumer firebaseConsumer;

  UserRegistrationDatasourceImpl({required this.firebaseConsumer});

  @override
  Future<User?> createEmailAccount({
    required String email,
    required String password,
  }) async {
    return await firebaseConsumer.createEmailAccount(
      email: email,
      password: password,
    );
  }

  @override
  Future<User?> createGoogleAccount() async {
    return await firebaseConsumer.createGoogleAccount();
  }

  @override
  Future<User?> loginAccount({
    required String email,
    required String password,
  }) async {
    return await firebaseConsumer.loginAccount(
      email: email,
      password: password,
    );
  }
}
