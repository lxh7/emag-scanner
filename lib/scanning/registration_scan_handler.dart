import 'package:flutter/material.dart';

import '../enums/scan_result.dart';
import '../util/registration_service.dart';
import '../util/vibrator.dart';
import 'base_scan_handler.dart';

class RegistrationScanHandler extends BaseScanHandler {
  RegistrationScanHandler({
    required this.getTokenFunc,
    required this.printer,
  }) {
    // nothing to do
  }

  final Future<String?> Function() getTokenFunc;
  final String printer;

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
    // Send to printer service
    var token = await getTokenFunc() ?? '';
    //var response =
    await RegistrationService().printDocuments(token, key, printer);
    //  if (response.data = 'OK') or whatever {
    scanPage.setScanResult(ScanResult.pass, 'Documents are being printed') ;
    // } else {      
    //    scanPage.setScanResult(ScanResult.error, '@{response.message}\nPlease refer to the information desk') ;
    // }
  }

  @override
  Widget buildBottomSheet(BuildContext context) {
    Vibrator.stopBuzzer();
    return const Text('Nothing special to show');
  }
}
