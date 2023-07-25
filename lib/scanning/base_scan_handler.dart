import 'dart:async';

import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '/app_settings.dart';
import '/data/data_manager.dart';
import '/enums/scan_result.dart';
import '/logging/logging.dart';
import '/pages/scan_page.dart';
import '/util/barcode_decoder.dart';

/// Handles the specifics during scanning.
///
/// A concrete handler is added to a generic scan page to handle the barcodes being scanned.
abstract class BaseScanHandler {
  late Logger logger;
  AppSettings? _appSettings;
  DataManager? _dataManager;

  BaseScanHandler() {
    logger = getLogger(runtimeType.toString());
  }

  AppSettings get appSettings {
    _appSettings ??= Provider.of<AppSettings>(scanPage.context, listen: false);
    return _appSettings!;
  }

  DataManager get dataManager {
    _dataManager ??= Provider.of<DataManager>(scanPage.context, listen: false);
    return _dataManager!;
  }

  /// the scan time for derived handlers
  late DateTime scanTime;

  /// link to the scan page we're servicing
  late ScanPageState scanPage;

  set page(ScanPageState page) {
    scanPage = page;
  }

  /// Return the title to show on the scan page
  String getTitle();
  String getSubTitle() => '';

  /// Handle the barcode(s) being scanned. The base handler does some preliminary handling
  /// such as decoding, and then transfers the handling to [BaseScanHandler.handleKey]
  Future handleBarcodes(List<Barcode> barcodes) async {
    if (barcodes.length > 1) {
      scanPage.setScanResult(ScanResult.error, 'Multiple codes in view');
      return;
    }
    var now = DateTime.now();
    scanTime = now.toUtc();
    final barcode = barcodes.first;
    logger.d(
        'Barcode found! ${barcode.rawValue}. Scan time ${now.toString()} (utc: ${scanTime.toString()})');
    await handleBarcode(barcode);
  }

  Future handleBarcode(Barcode barcode) async {
    var key = BarcodeDecoder.decode(barcode);
    if (key == null) {
      scanPage.setScanResult(ScanResult.error, 'Not a valid EMAG QR-code');
      return;
    }
      await handleKey(key);
    // }
  }

  /// Handle a key retrieved from the barcode scanned.
  Future handleKey(String key) async {
    logger.d('BaseScanhandler.handleKey()');
    // no implementation here, but also not abstract
    return;
  }
}
