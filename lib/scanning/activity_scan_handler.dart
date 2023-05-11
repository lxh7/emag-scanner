import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/enums/scan_result.dart';
import '/models/scan_info.dart';
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
  Future handleKey(String key) async {
    var info = ScanInfo(
      dataManager.selectedActivity!.id,
      key,
      DateTime.now(),
    );
    final result = await dataManager.checkAccess(info);
    previousScanTime = result.prevScanTime;
    // set message based on check
    var message = '';
    switch (result.scanResult) {
      case ScanResult.none:
      case ScanResult.pass:
        // ok!
        break;
      case ScanResult.check:
        if (previousScanTime != null) {
          message =
              'This code has been scanned earlier for this activity, on ${DateFormat.yMd().format(previousScanTime!)} at ${DateFormat.Hm().format(previousScanTime!)}.';
          // 'Individual has been scanned before',
        } else {
          message = 'Unsure about this person: reason unknown.';
        }
        message = '$message Perform additional check(s) (e.g. stamp)';
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
  }

  @override
  Widget buildBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: scanPage.getActionColor(context),
      height: 100,
      child: Column(children: [
        Center(child: Text(scanPage.scanMessage)),
        ElevatedButton(
          child: Center(
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
