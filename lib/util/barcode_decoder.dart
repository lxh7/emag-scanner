import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeDecoder {
  static String? decode(Barcode barcode) {
    // EMAG person identifiers are 9 random bytes. The API expects those, base64 encoded.
    if (barcode.type == BarcodeType.text && barcode.rawValue?.length == 12) {
      return barcode.rawValue!;
    }
    return null;
  }
}
