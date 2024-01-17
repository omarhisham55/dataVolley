import 'package:data_volley_match/config/error/exceptions.dart';
import 'package:data_volley_match/core/firebase/firestore/user_firestore_consumer.dart';
import 'package:data_volley_match/core/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseManager {
  Future<User?> createEmailAccount({
    required String email,
    required String password,
  });
  Future<User?> createGoogleAccount();
  Future<User?> loginAccount({
    required String email,
    required String password,
  });
}

class FirebaseConsumer implements FirebaseManager {
  final FirebaseAuth client;
  final UserFirestoreConsumer storage;

  FirebaseConsumer({required this.client, required this.storage});
  @override
  Future<User?> createEmailAccount({
    required String email,
    required String password,
  }) async {
    try {
      await client.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return loginAccount(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      return Future.error(_handleFirebaseAuthException(error));
    }
  }

  @override
  Future<User?> loginAccount({
    String? email,
    String? password,
    AuthCredential? credential,
  }) async {
    final UserCredential response;
    if (email != null && password != null) {
      response = await client.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } else if (credential != null) {
      response = await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      return client.currentUser;
    }
    await storage.saveUser(user: response.user!);
    return response.user;
  }

  @override
  Future<User?> createGoogleAccount() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return loginAccount(credential: credential);
    } on FirebaseAuthException catch (error) {
      return Future.error(_handleFirebaseAuthException(error));
    }
  }

  static Future<void> logout() {
    return FirebaseAuth.instance.signOut();
  }

  static dynamic _handleFirebaseAuthException(
    FirebaseAuthException error,
  ) {
    switch (error.code) {
      case "INVALID_LOGIN_CREDENTIALS":
        Constants.showToast(
          msg: const InvalidLoginCredentials().msg!,
          color: Colors.red,
        );
        throw const InvalidLoginCredentials();
      case "invalid-email":
        Constants.showToast(
          msg: const InvalidEmailFormat().msg!,
          color: Colors.red,
        );
        throw const InvalidEmailFormat();
      case "wrong-password":
        Constants.showToast(
          msg: const InvalidPassword().msg!,
          color: Colors.red,
        );
        throw const InvalidPassword();
      case "user-not-found":
        Constants.showToast(
          msg: const UserNotFound().msg!,
          color: Colors.red,
        );
        throw const UserNotFound();
      case "email-already-in-use":
        Constants.showToast(
          msg: const EmailInUse().msg!,
          color: Colors.red,
        );
        throw const EmailInUse();
      case "invalid-phone-number":
        Constants.showToast(
          msg: const InvalidPhoneNumber().msg!,
          color: Colors.red,
        );
      case "too-many-requests":
        Constants.showToast(
          msg: const TooManyRequests().msg!,
          color: Colors.red,
        );
      default:
        Constants.showToast(
          msg: UnknownError(error.code).msg!,
          color: Colors.red,
        );
        throw const UnknownError();
    }
  }
}
