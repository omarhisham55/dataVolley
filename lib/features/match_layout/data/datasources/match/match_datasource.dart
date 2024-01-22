import 'package:data_volley_match/core/firebase/firestore/match_firestore_consumer.dart';
import 'package:data_volley_match/features/match_layout/data/models/match_model.dart';

abstract class MatchDatasource {
  Future<bool> saveMatch({required MatchModel match});
  Future<Map<String, List<MatchModel>>> getMatches();
  Future<bool> editMatch({required MatchModel match});
  Future<bool> deleteMatch({required MatchModel match});
}

class MatchDatasourceImpl implements MatchDatasource {
  final MatchFirestoreConsumer matchFirestoreConsumer;

  MatchDatasourceImpl({required this.matchFirestoreConsumer});
  @override
  Future<bool> deleteMatch({required MatchModel match}) async {
    return await matchFirestoreConsumer.deleteMatch(match: match);
  }

  @override
  Future<bool> editMatch({required MatchModel match}) async {
    return await matchFirestoreConsumer.editMatch(match: match);
  }

  @override
  Future<Map<String, List<MatchModel>>> getMatches() async {
    return await matchFirestoreConsumer.getAllLevelMatch();
  }

  @override
  Future<bool> saveMatch({required MatchModel match}) async {
    return await matchFirestoreConsumer.saveMatch(match: match);
  }
}
