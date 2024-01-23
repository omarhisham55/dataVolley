import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_volley_match/core/firebase/firestore/user_firestore_consumer.dart';
import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/features/match_layout/data/models/match_model.dart';
import 'package:data_volley_match/features/registration/data/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class MatchFirestoreManager {
  Future<bool> saveMatch({required MatchModel match});
  Future<bool> deleteMatch({required MatchModel match});
  Future<bool> editMatch({required MatchModel match});
  Future<List<MatchModel>> getSingleLevelMatch({required String level});
  Future<Map<String, List<MatchModel>>> getAllLevelMatch();
}

class MatchFirestoreConsumer implements MatchFirestoreManager {
  final FirebaseFirestore client;
  late final UserModel user = UserFirestoreConsumer(client: client).userModel;
  Map<String, List<MatchModel>> matches = {};

  MatchFirestoreConsumer({required this.client});

  @override
  Future<bool> deleteMatch({required MatchModel match}) async {
    try {
      await client
          .collection('users')
          .doc(user.id)
          .collection('level')
          .doc(match.level)
          .collection('matches')
          .doc(match.id)
          .delete();
      return true;
    } catch (error) {
      Constants.showToast(msg: error.toString());
      return false;
    }
  }

  @override
  Future<bool> editMatch({required MatchModel match}) async {
    try {
      await client
          .collection('users')
          .doc(user.id)
          .collection('level')
          .doc(match.level)
          .collection('matches')
          .doc(match.id)
          .update(match.toMap());
      return true;
    } catch (error) {
      Constants.showToast(msg: error.toString());
      return false;
    }
  }

  @override
  Future<Map<String, List<MatchModel>>> getAllLevelMatch() async {
    List<String> levels = ['15', '17', '19', '1st', 'friendly'];
    for (var element in levels) {
      final List<MatchModel> level = await getSingleLevelMatch(level: element);
      matches[element] = level;
    }
    debugPrint(matches.toString());
    return matches;
  }

  @override
  Future<List<MatchModel>> getSingleLevelMatch({required String level}) async {
    List<MatchModel> matches = [];
    try {
      await client
          .collection('users')
          .doc(user.id)
          .collection('level')
          .doc(level)
          .collection('matches')
          .get()
          .then((value) {
        for (var element in value.docs) {
          matches.add(MatchModel.fromJson(element.data()));
        }
      });
    } catch (error) {
      Constants.showToast(
        msg: error.toString(),
      );
    }
    return matches;
  }

  @override
  Future<bool> saveMatch({required MatchModel match}) async {
    try {
      await client
          .collection('users')
          .doc(user.id)
          .collection('level')
          .doc(match.level)
          .collection('matches')
          .doc(match.id)
          .set(match.toMap());
      return true;
    } catch (error) {
      Constants.showToast(msg: error.toString());
      return false;
    }
  }
}
