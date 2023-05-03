import 'package:flutter/material.dart';

class MyDialog {
  static AlertDialog notImplemented(BuildContext context, String message) {
    return AlertDialog(
      title: Text(
        'Not implemented',
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
}
