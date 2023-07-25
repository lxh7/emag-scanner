// import 'package:flutter/material.dart';

import '../enums/scan_result.dart';
import '../util/registration_service.dart';
// import '../util/vibrator.dart';
import 'base_scan_handler.dart';

class RegistrationScanHandler extends BaseScanHandler {
  Future<String?> Function() getTokenFunc;
  String printer = '';

  RegistrationScanHandler(this.getTokenFunc, this.printer);

  @override
  String getTitle() {
    return 'Scan for registration';
  }

  @override
  String getSubTitle() {
    return 'Printing to $printer';
  }

  @override
  Future handleKey(String key) async {
    logger.d('RegistrationScanHandler.handleKey()');
    // Send to printer service
    getTokenFunc().then((token) {
      //var response =
      RegistrationService()
          .printDocuments(token ?? '', key, printer)
          .then((dummy) {
        //  if (response.data = 'OK') or whatever {
        scanPage.setScanResult(ScanResult.pass, 'Documents are being printed');
        // } else {
        //    scanPage.setScanResult(ScanResult.error, '@{response.message}\nPlease refer to the information desk') ;
        // }
      });
    });
  }
}
