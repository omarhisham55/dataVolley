import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_volley_match/features/registration/data/models/user_model.dart';

abstract class MatchFirestoreManager {
  Future<bool> saveMatch({required UserModel user});
  Future<bool> deleteMatch({required UserModel user});
  Future<bool> editMatch({required UserModel user});
  Future<bool> getMatch({required UserModel user});
}

class MatchFirestoreConsumer implements MatchFirestoreManager {
  final FirebaseFirestore client;

  MatchFirestoreConsumer({required this.client});
  @override
  Future<bool> deleteMatch({required UserModel user}) {
    // TODO: implement deleteMatch
    throw UnimplementedError();
  }

  @override
  Future<bool> editMatch({required UserModel user}) {
    // TODO: implement editMatch
    throw UnimplementedError();
  }

  @override
  Future<bool> getMatch({required UserModel user}) {
    // TODO: implement getMatch
    throw UnimplementedError();
  }

  @override
  Future<bool> saveMatch({required UserModel user}) {
    // TODO: implement saveMatch
    throw UnimplementedError();
  }
}
