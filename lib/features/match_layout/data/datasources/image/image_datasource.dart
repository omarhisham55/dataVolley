import 'package:data_volley_match/core/firebase/firestore/firebase_storage.dart';

abstract class ImageDatasource {
  Future<String?> addTeamImage();
}

class ImageDatasourceImpl extends ImageDatasource {
  final FirebaseStorageConsumer firebaseStorageConsumer;

  ImageDatasourceImpl({required this.firebaseStorageConsumer});
  @override
  Future<String?> addTeamImage() async {
    return await firebaseStorageConsumer.uploadTeamImg();
  }
}
