import 'package:flutter/material.dart';

class MyDialog {
  static AlertDialog _dialog(
    BuildContext context,
    String title,
    String message, {
    Color? backgroundColor,
    Icon? icon,
    Color? iconColor,
    List<Widget>? actions,
    Function()? onClose,
  }) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      backgroundColor: backgroundColor,
      icon: icon,
      iconColor: iconColor,
      actions: actions ??
          [
            TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  onClose?.call();
                }),
          ],
    );
  }

  static void showNotImplemented(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _dialog(context, 'Not implemented', message);
      },
    );
  }

  static void showInfo(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _dialog(context, 'Information', message);
      },
    );
  }

  static void showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _dialog(context, 'Error', message);
      },
    );
  }

  static Future<bool> confirmAsync(BuildContext context, String message) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return _dialog(context, 'Confirm', message, actions: [
          TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              }),
          TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              }),
        ]);
      },
    );
    return result == true;
  }

  static void showPopup(BuildContext context, String caption, String message,
      {Color? backgroundColor,
      Color? iconColor,
      Icon? icon,
      Function()? onClose}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _dialog(
          context,
          caption,
          message,
          backgroundColor: backgroundColor,
          icon: icon,
          iconColor: iconColor,
          onClose: onClose,
        );
      },
    );
  }
}
