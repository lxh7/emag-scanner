import 'package:flutter/material.dart';

import '../util/registration_service.dart';
import 'base_scan_handler.dart';

class RegistrationScanHandler extends BaseScanHandler {
  RegistrationScanHandler({
    required this.getAccessToken,
    required this.printer,
  }) {
    // nothing to do
  }

  final Future<String?> Function() getAccessToken;
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
    var token = await getAccessToken() ?? '';
    await RegistrationService().printDocuments(token, key, printer);
  }

  @override
  Widget buildBottomSheet(BuildContext context) {
    return Text('Nothing special to show');
  }
}
