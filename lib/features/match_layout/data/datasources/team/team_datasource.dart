import 'package:data_volley_match/core/firebase/firestore/team_firestore_consumer.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';

abstract class TeamDatasource {
  Future<bool> saveTeam({required TeamModel team});
  Future<Map<String, List<TeamModel>>> getTeams();
  Future<dynamic> editTeam();
  Future<bool> deleteTeam({required TeamModel team});
}

class TeamDatasourceImpl extends TeamDatasource {
  final TeamFirestoreConsumer firestoreConsumer;

  TeamDatasourceImpl({required this.firestoreConsumer});
  @override
  Future<bool> saveTeam({
    required TeamModel team,
  }) async {
    return await firestoreConsumer.saveTeam(team: team);
  }

  @override
  Future<Map<String, List<TeamModel>>> getTeams() async {
    return await firestoreConsumer.getTeamsInAllLevels();
  }

  @override
  Future<bool> deleteTeam({required TeamModel team}) async {
    return await firestoreConsumer.deleteTeam(team);
  }

  @override
  Future editTeam() {
    // TODO: implement editTeam
    throw UnimplementedError();
  }
}