import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/core/utils/images.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirebasrStorageManager {
  Future<String?> uploadTeamImg();
}

class FirebaseStorageConsumer implements FirebasrStorageManager {
  final FirebaseStorage client;
  final ImageManager imageManager;

  FirebaseStorageConsumer({required this.client, required this.imageManager});
  @override
  Future<String?> uploadTeamImg() async {
    await imageManager.getImageFromDevice();
    final response = client
        .ref()
        .child('images/')
        .child(Uri.file(imageManager.file!.path).pathSegments.last);
    if (imageManager.file != null) {
      try {
        return await response.putFile(imageManager.file!).then(
              (value) async => await value.ref.getDownloadURL(),
            );
      } on FirebaseException catch (error) {
        Constants.showToast(msg: error.message.toString());
      }
    }
    return null;
  }
}
