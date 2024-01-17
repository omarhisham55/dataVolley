import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_volley_match/core/firebase/firestore/user_firestore_consumer.dart';
import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/core/utils/strings.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';
import 'package:data_volley_match/features/registration/data/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class TeamFirestoreManager {
  Future<bool> saveTeam({required TeamModel team});
  Future<List<TeamModel>> getTeamsInSingleLevel({
    required String level,
  });
  Future<Map<String, List<TeamModel>>> getTeamsInAllLevels();
  Future<bool> deleteTeam();
  Future<bool> editTeam();
}

class TeamFirestoreConsumer implements TeamFirestoreManager {
  final FirebaseFirestore client;
  late final UserModel user = UserFirestoreConsumer(client: client).userModel;
  Map<String, List<TeamModel>> teams = {};

  TeamFirestoreConsumer({required this.client});
  @override
  Future<bool> deleteTeam() {
    // TODO: implement deleteTeam
    throw UnimplementedError();
  }

  @override
  Future<bool> editTeam() {
    // TODO: implement editTeam
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<TeamModel>>> getTeamsInAllLevels() async {
    List<String> levels = ['15', '17', '19', '1st'];
    for (var element in levels) {
      final List<TeamModel> level = await getTeamsInSingleLevel(level: element);
      teams[element] = level;
    }
    debugPrint(teams.toString());
    return teams;
  }

  @override
  Future<List<TeamModel>> getTeamsInSingleLevel({required String level}) async {
    List<TeamModel> teams = [];
    try {
      await client
          .collection('users')
          .doc(user.id)
          .collection('level')
          .doc(level)
          .collection('teams')
          .get()
          .then((value) {
        for (var element in value.docs) {
          teams.add(TeamModel.fromJson(element.data()));
        }
      });
    } catch (error) {
      Constants.showToast(msg: error.toString());
    }
    return teams;
  }

  @override
  Future<bool> saveTeam({required TeamModel team}) async {
    for (var value in teams[team.level] ?? []) {
      if (value == team) {
        Constants.showToast(msg: MainStrings.teamExists, color: Colors.amber);
        return false;
      } else {
        continue;
      }
    }
    try {
      await client
          .collection('users')
          .doc(user.id)
          .collection('level')
          .doc(team.level)
          .collection('teams')
          .add(team.toMap());
      return true;
    } catch (error) {
      Constants.showToast(msg: error.toString());
      return false;
    }
  }
}
