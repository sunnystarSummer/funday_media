import 'package:flutter/material.dart';

class DialogView {
  DialogView._();

  static Future showError(
    BuildContext context, {
    required int code,
    required String message,
  }) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("錯誤"),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("取消"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text("確定"),
            onPressed: () {
              // Perform some action
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
