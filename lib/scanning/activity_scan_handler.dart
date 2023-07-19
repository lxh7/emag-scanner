import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/enums/scan_result.dart';
import '/models/domain.dart';
import 'base_scan_handler.dart';

class ActivityScanHandler extends BaseScanHandler {
  DateTime? previousScanTime;

  @override
  String getTitle() {
    return 'Scan for access';
  }

  @override
  String getSubTitle() {
    return dataManager.selectedActivity?.name ?? '';
  }

  @override
  void handleKey(String key) {
    var info = ScanInfo(
      dataManager.selectedActivity!.id,
      key,
      DateTime.now(),
    );
    dataManager.checkAccess(info).then((result) {
      previousScanTime = result.prevScanTime;
      // set message based on check
      var message = '';
      switch (result.scanResult) {
        case ScanResult.none:
        case ScanResult.pass:
          // no message
          break;
        case ScanResult.check:
          if (previousScanTime != null) {
            message =
                'This code has been scanned earlier for this activity,\non ${DateFormat.yMd().format(previousScanTime!)} at ${DateFormat.Hm().format(previousScanTime!)}.';
          } else {
            message = 'Unsure about this person: reason unknown.';
          }
          message = '$message Please perform additional check(s)';
          break;
        case ScanResult.deny:
          message =
              'This code does not belong to any participant on this activity';
          break;
        case ScanResult.error:
          if (result.message == '') {
            message = 'An error occurred during the processing of the code';
          } else {
            message = result.message;
          }
          break;
      }
      scanPage.setScanResult(result.scanResult, message);
    });
  }

  @override
  Widget buildBottomSheet(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      color: scanPage.scanResult.getColor(
          theme.bottomSheetTheme.backgroundColor ?? Colors.blueAccent),
      height: 100,
      child: Column(children: [
        Center(child: Text(scanPage.scanMessage)),
        ElevatedButton(
          child: const Center(
            child: Text('Dismiss'),
          ),
          onPressed: () {
            Navigator.pop(context);
            scanPage.setScanResult(ScanResult.none, '');
          },
        ),
      ]),
    );
  }
}
