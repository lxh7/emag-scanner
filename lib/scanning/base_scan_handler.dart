import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:scan/data/data_manager.dart';

import '../app_settings.dart';
import '/enums/scan_result.dart';
import '/pages/scan.dart';
import '/util/barcode_decoder.dart';

/// Handles the specifics during scanning.
///
/// A concrete handler is added to a generic scan page to handle the barcodes being scanned.
abstract class BaseScanHandler {
  AppSettings? _appSettings;
  DataManager? _dataManager;

  AppSettings get appSettings {
    _appSettings ??= Provider.of<AppSettings>(scanPage.context, listen: false);
    return _appSettings!;
  }

  DataManager get dataManager {
    _dataManager ??= Provider.of<DataManager>(scanPage.context, listen: false);
    return _dataManager!;
  }

  /// keep the scan time for further reference
  DateTime scanTime = DateTime.now();

  /// link to the scan page we're servicing
  late ScanPageState scanPage;

  set page(ScanPageState page) {
    scanPage = page;
  }

  /// Return the title to show on the scan page
  String getTitle();
  String getSubTitle();

  /// Build a modal "bottom sheet" with error information
  Widget buildBottomSheet(BuildContext context);

  /// Handle the barcode(s) being scanned. The base handler does some preliminary handling
  /// such as decoding, and then transfers the handling to [BaseScanHandler.handleKey]
  void handleBarcodes(List<Barcode> barcodes) {
    if (barcodes.length > 1) {
      scanPage.setScanResult(ScanResult.error, 'Multiple codes in view');
      return;
    }
    scanTime = DateTime.now();
    final barcode = barcodes.first;
    debugPrint('Barcode found! ${barcode.rawValue}');
    handleBarcode(barcode);
  }

  void handleBarcode(Barcode barcode) {
    var personKey = BarcodeDecoder.decode(barcode);
    if (personKey == null) {
      scanPage.setScanResult(ScanResult.error, 'Not a valid EMAG QR-code');
      return;
    }
    handleKey(personKey);
  }

  /// Handle a key retrieved from the barcode scanned.
  Future handleKey(String key) {
    // no implementation here, but also not abstract
    return Future.value(true); // dummy return
  }

}
