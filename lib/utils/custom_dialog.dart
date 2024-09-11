import 'package:flutter/material.dart';

class CustomDialogBox {
  static Future<dynamic> customDialog(BuildContext context, TextTheme textTheme,
      String message, List<Widget> actions) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text("Woocommerce App"),
          content: Text(
            message,
            textDirection: TextDirection.rtl,
          ),
          actions: actions,
        );
      },
    );
  }
}
