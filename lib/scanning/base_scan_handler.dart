import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '/enums/scan_result.dart';
import '/pages/scan.dart';
import '/util/barcode_decoder.dart';

/// Handles the specifics during scanning.
///
/// A concrete handler is added to a generic scan page to handle the barcodes being scanned.
abstract class BaseScanHandler {
  /// keep the scan time for further reference
  DateTime scanTime = DateTime.now();

  /// link to the scan page we're servicing
  late ScanPageState scanPage;

  set page(ScanPageState page) {
    scanPage = page;
  }

  /// Return the title to show on the scan page
  String getTitle();

  /// Build a modal "bottom sheet" with error information
  Widget buildBottomSheet(BuildContext context);

  /// Handle the barcode(s) being scanned. The base handler does some preliminary handling
  /// such as decoding, and then transfers the handling to [BaseScanHandler.handleKey]
  void handleBarCodes(List<Barcode> barcodes) {
    if (barcodes.length > 1) {
      scanPage.setScanResult(ScanResult.error, 'Multiple codes in view');
      return;
    }
    scanTime = DateTime.now();
    final barcode = barcodes.first;
    debugPrint('Barcode found! ${barcode.rawValue}');
    var personKey = BarcodeDecoder.decode(barcode);
    if (personKey == null) {
      scanPage.setScanResult(ScanResult.error, 'Not a valid EMAG QR-code');
      return;
    }
    handleKey(personKey);
  }

  /// Handle a key retrieved from the barcode scanned.
  Future handleKey(String key);
}
