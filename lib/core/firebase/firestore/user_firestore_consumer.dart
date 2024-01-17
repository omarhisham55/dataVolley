import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/features/registration/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class UserFirestoreManager {
  Future<bool> saveUser({required firebase_auth.User user});
  // Future<UserModel?> getUser({required String id});
}

class UserFirestoreConsumer implements UserFirestoreManager {
  final FirebaseFirestore client;
  UserModel userModel = UserModel(
    id: firebase_auth.FirebaseAuth.instance.currentUser!.uid,
    email: firebase_auth.FirebaseAuth.instance.currentUser!.email!,
  );

  UserFirestoreConsumer({required this.client});

  @override
  Future<bool> saveUser({required firebase_auth.User user}) async {
    try {
      userModel = UserModel(id: user.uid, email: user.email!);
      await client.collection('users').doc(user.uid).set(userModel.toMap());
      return true;
    } catch (error) {
      Constants.showToast(msg: error.toString());
      return false;
    }
  }

  /* @override
  Future<UserModel?> getUser({required String id}) async {
    try {
      final response = await client.collection('users').doc(id).get();
      return UserModel.fromJson(response.data()!);
    } catch (error) {
      Constants.showToast(msg: error.toString());
      return null;
    }
  } */
}
