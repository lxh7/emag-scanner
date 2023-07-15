import 'package:intl/intl.dart'; // for date format
// import 'package:intl/date_symbol_data_local.dart'; // for other locales
import 'package:flutter/material.dart';
import '/models/domain.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    super.key,
    required this.activity,
    this.enabled = true,
    this.tapAction,
    this.longPressAction,
    this.trailingWidget,
    this.trailingAction,
  });

  static const int maxTitleLen = 60;
  final Activity activity;
  final bool enabled;
  final void Function()? tapAction;
  final void Function()? longPressAction;
  final Widget? trailingWidget;
  final void Function()? trailingAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget? trailingWrapper;
    if (trailingWidget != null) {
      trailingWrapper = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: trailingAction,
        child: Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          alignment: Alignment.center,
          child: trailingWidget,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(
          Icons.qr_code_scanner,
          size: 50,
          color: enabled
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.inversePrimary,
        ),
        title: Text(activity.name.length > maxTitleLen
            // ignore: prefer_interpolation_to_compose_strings
            ? activity.name.substring(0, maxTitleLen) + '...'
            : activity.name),
        subtitle: Text(
            DateFormat('dd-MM-yyyy HH:mm - ').format(activity.start) +
                DateFormat('HH:mm').format(activity.end)),
        trailing: trailingWrapper,
        textColor: theme.colorScheme.onPrimary,
        tileColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(2),
        ),
        enabled: enabled,
        onTap: tapAction,
        onLongPress: longPressAction,
      ),
    );
  }
}
