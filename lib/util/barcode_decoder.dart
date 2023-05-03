import 'dart:convert';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeDecoder {
  static String? decode(Barcode barcode) {
    // EMAG person identifiers are 9 random bytes. The API expects those, base64 encoded.
    if (barcode.type == BarcodeType.unknown && barcode.rawBytes?.length == 9) {
      return base64Encode(barcode.rawBytes!);
    }
    return null;
  }
}
