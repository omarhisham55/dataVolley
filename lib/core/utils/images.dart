import 'dart:io';

import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/core/utils/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;

const String baseImg = "assets/images";

class MainImages {
  static const String logo = "$baseImg/logo.png";
  static const String clubExample = "$baseImg/asc.png";
  static const String unknownClub = "$baseImg/unknown.jpeg";
}

class ImageManager {
  File? file;
  static final ImagePicker imagePicker = ImagePicker();

  Future<void> storagePermissionCheck() async {
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
  }

  Future<void> getImageFromDevice() async {
    storagePermissionCheck().then((value) async {
      await imagePicker
          .pickImage(
        source: ImageSource.gallery,
      )
          .then((value) async {
        Constants.showToast(
          msg: 'adding image...',
          toastLength: Toast.LENGTH_LONG,
        );
        if (value != null) {
          file = await processImage(value);
          // file = File(image.path);
          return;
        }
        Constants.showToast(
          msg: 'Image error try again',
          color: MainColors.errorColor,
        );
      });
    });
  }

  Future<File> processImage(XFile image) async {
    final path = image.path;
    final File file = File(path);
    if (!path.toLowerCase().endsWith('.png')) {
      final imgBytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(imgBytes);
      img.encodePng(decodedImage!);
    }
    return file;
  }
}
