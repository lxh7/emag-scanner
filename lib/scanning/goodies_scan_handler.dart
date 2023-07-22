import 'package:flutter/material.dart';

import '/enums/scan_result.dart';
import '/util/routes.dart';
import '/util/vibrator.dart';
import 'base_scan_handler.dart';

class GoodiesScanHandler extends BaseScanHandler {

  @override
  String getTitle() {
    return 'Scan for goodies';
  }

  @override
  void handleKey(String key) {
    //var token = await getTokenFunc() ?? '';
    dataManager.getPerson(key).then((person) {
      if (person == null) {
        scanPage.setScanResult(ScanResult.error,
            'QR code not found\nPlease refer to the information desk');
      } else {
        scanPage.showResultInAPage(Routes.goodiesShow, arguments: person);
      }
    });
  }

  @override
  Widget buildBottomSheet(BuildContext context) {
    Vibrator.stopBuzzer();
    return const Text('Nothing special to show');
  }
}
