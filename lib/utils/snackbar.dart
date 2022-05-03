import 'package:flutter/material.dart';

class SnackBarHelper {
  static show(
      {required BuildContext context,
      required String msg,
      Color color = Colors.blue}) {
    SnackBar snackBar = SnackBar(
      backgroundColor: color,
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
