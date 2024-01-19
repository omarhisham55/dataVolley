import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/core/utils/images.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebasrStorageManager {
  Future<void> uploadTeamImg();
}

class FirebaseStorageConsumer implements FirebasrStorageManager {
  final FirebaseStorage client;
  final ImageManager imageManager;

  FirebaseStorageConsumer({required this.client, required this.imageManager});
  @override
  Future<void> uploadTeamImg() async {
    await imageManager.getImageFromDevice();
    final response = client
        .ref()
        .child('images/')
        .child(Uri.file(imageManager.file!.path).pathSegments.last);
    try {
      await response.putFile(imageManager.file!);
    } on FirebaseException catch (error) {
      Constants.showToast(msg: error.message.toString());
    }
  }
}
