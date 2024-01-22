import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  static void showToast({
    required String msg,
    Color? color,
    ToastGravity? gravity,
    Toast? toastLength,
  }) =>
      Fluttertoast.showToast(
        msg: msg,
        backgroundColor: color,
        gravity: gravity,
        toastLength: toastLength,
      );

  static void goTo(BuildContext context, String route, {Object? arguments}) =>
      Navigator.pushNamed(context, route, arguments: arguments);

  static String generateRandomId() {
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    String id = '';

    for (int i = 0; i < 27; i++) {
      id += chars[random.nextInt(chars.length)];
    }

    return id;
  }

  static openDialog(BuildContext context, String msgTitle) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(msgTitle),
      ),
    );
  }
}
