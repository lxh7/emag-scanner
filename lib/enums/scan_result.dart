import 'package:flutter/material.dart';

enum ScanResult {
  none, // no status
  pass, // person is registered and thus may enter
  check, // person is registered but has been scanned before. additional checking needed
  deny, // person is not registered
  error, // error during processing
}

extension ScanResultExtension on ScanResult{
  Color getColor(Color def){
    switch (this) {
      case ScanResult.none:
        return def;
      case ScanResult.pass:
        return Colors.green;
      case ScanResult.check:
        return Colors.orange;
      case ScanResult.deny:
      case ScanResult.error:
        return Colors.red;
    }
  }
  
}
