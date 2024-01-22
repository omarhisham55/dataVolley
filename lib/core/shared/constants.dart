import 'dart:math';

import 'package:data_volley_match/core/utils/colors.dart';
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

  static void goBackTo(BuildContext context, String route,
          {Object? arguments}) =>
      Navigator.popUntil(context, (routes) => routes.settings.name == route);

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

  static openDialog({
    required BuildContext context,
    required String msgTitle,
    required String msgContent,
    required List<Widget> actions,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(msgTitle),
        backgroundColor: MainColors.secondaryColor,
        content: Text(
          msgContent,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: actions,
      ),
    );
  }
}
