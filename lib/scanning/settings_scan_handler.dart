import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'base_scan_handler.dart';
import '/util/my_dialog.dart';

class SettingsScanHandler extends BaseScanHandler {
  @override
  String getTitle() {
    return 'Scan settings';
  }

  @override
  Future handleBarcode(Barcode barcode) async {
    logger.d('SettingsScanHandler.handleBarcode()');
    if (barcode.rawValue == null) {
      MyDialog.showError(scanPage.context, 'No data in barcode');
      return;
    }
    if (barcode.type != BarcodeType.text) {
      MyDialog.showError(scanPage.context, 'Invalid barcode');
      return;
    }
    if (barcode.displayValue == null) {
      MyDialog.showError(
          scanPage.context, 'Barcode does not contain proper data');
      return;
    }
    var settingsInfo = json.decode(barcode.displayValue!);
    appSettings.setValues(settingsInfo);
    Navigator.pop(scanPage.context);
  }
}
