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
  void handleBarcode(Barcode barcode) {
    if (barcode.rawValue == null) {
      MyDialog.error(scanPage.context, 'No data in barcode');
      return;
    }
    if (barcode.type != BarcodeType.text) {
      MyDialog.error(scanPage.context, 'Invalid barcode');
      return;
    }
    if (barcode.displayValue == null) {
      MyDialog.error(scanPage.context, 'Barcode does not contain proper data');
      return;
    }
    var settingsInfo = json.decode(barcode.displayValue!);
    var totalSet = appSettings.setValues(settingsInfo);
    MyDialog.info(scanPage.context, "$totalSet, values set");
    Navigator.pop(scanPage.context);
  }

  @override
  Widget buildBottomSheet(BuildContext context) {
    return Text('Nothing special to show');
  }
}
