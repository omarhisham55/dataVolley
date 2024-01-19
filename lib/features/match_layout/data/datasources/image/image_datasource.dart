import 'package:data_volley_match/core/firebase/firestore/firebase_storage.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';

abstract class ImageDatasource {
  Future<void> addTeamImage({required TeamModel team});
}

class ImageDatasourceImpl extends ImageDatasource {
  final FirebaseStorageConsumer firebaseStorageConsumer;

  ImageDatasourceImpl({required this.firebaseStorageConsumer});
  @override
  Future<void> addTeamImage({required TeamModel team}) async {
    return await firebaseStorageConsumer.uploadTeamImg();
  }
}
