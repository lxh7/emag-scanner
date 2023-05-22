import 'package:flutter/material.dart';

class PrinterTile extends StatelessWidget {
  const PrinterTile({
    super.key,
    required this.printer,
    this.tapAction,
    this.longPressAction,
  });

  static const int maxTitleLen = 60;
  final String printer;
  final void Function()? tapAction;
  final void Function()? longPressAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);   

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(
          Icons.print,
          size: 50,
          color: theme.colorScheme.onPrimary,
        ),
        title: Text(printer.length > maxTitleLen
            // ignore: prefer_interpolation_to_compose_strings
            ? printer.substring(0, maxTitleLen) + '...'
            : printer),       
        textColor: theme.colorScheme.onPrimary,
        tileColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(2),
        ),
        onTap: tapAction,
        onLongPress: longPressAction,
      ),
    );
  }
}
