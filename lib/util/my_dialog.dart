import 'package:flutter/material.dart';

class MyDialog {
  static AlertDialog _dialog(
      BuildContext context, String title, String message) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  static AlertDialog notImplemented(BuildContext context, String message) {
    return _dialog(context, 'Not implemented', message);
  }

  static AlertDialog info(BuildContext context, String message) {
    return _dialog(context, 'Information', message);
  }

  static AlertDialog error(BuildContext context, String message) {
    return _dialog(context, 'Error', message);
  }
}
