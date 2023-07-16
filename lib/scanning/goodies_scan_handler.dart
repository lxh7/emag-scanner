import 'package:flutter/material.dart';

import '/enums/scan_result.dart';
import '/util/routes.dart';
import '/util/vibrator.dart';
import 'base_scan_handler.dart';

class GoodiesScanHandler extends BaseScanHandler {
  Set<int> categories;

  GoodiesScanHandler(this.categories);

  @override
  String getTitle() {
    return 'Scan for goodies';
  }

  @override
  Future handleKey(String key) async {
    //var token = await getTokenFunc() ?? '';
    final person = await dataManager.getPerson(key);
    if (person == null) {
      scanPage.setScanResult(ScanResult.error,
          'QR code not found\nPlease refer to the information desk');
    } else {
      scanPage.showResultInAPage(Routes.goodiesShow, person);
    }
  }

  @override
  Widget buildBottomSheet(BuildContext context) {
    Vibrator.stopBuzzer();
    return const Text('Nothing special to show');
  }
}
