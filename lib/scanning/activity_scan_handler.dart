// import 'package:flutter/material.dart';

import 'base_scan_handler.dart';
import '/enums/scan_result.dart';
import '/models/domain.dart';
import '/util/my_formats.dart';

class ActivityScanHandler extends BaseScanHandler {
  DateTime? previousScanTime;
  late Activity _selectedActivity;
  ActivityScanHandler(Activity activity) {
    _selectedActivity = activity;
  }

  @override
  String getTitle() {
    return 'Scan for access';
  }

  @override
  String getSubTitle() {
    return _selectedActivity.name;
  }

  @override
  Future handleKey(String key) async {
    logger.d('ActivityScanhandler.handleKey()');
    var info = ScanInfo(
      _selectedActivity.id,
      key,
      scanTime,
    );
    late AccessCheckResult result;
    try {
      result = await dataManager.checkAccess(info);
    } catch (e) {
      scanPage.setScanResult(ScanResult.error, e.toString());
      return;
    }
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
          logger.d('Previous scan time UTC ${previousScanTime!.toString()}');
          message =
              'This code has been scanned earlier for this activity \n(on ${MyFormats.dateTime.format(previousScanTime!.toLocal())}).';
        } else {
          message = 'Unsure about this person: reason unknown.';
        }
        message = '$message\n Please perform additional check(s)';
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
}
