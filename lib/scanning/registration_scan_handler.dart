import 'package:flutter/material.dart';

import '/util/registration_server_api.dart';
import 'base_scan_handler.dart';

class RegistrationScanHandler extends BaseScanHandler {
  @override
  String getTitle() {
    return 'Scan for registration';
  }
  
  @override
  String getSubTitle() {
return '';
  }

  @override
  Future handleKey(String key) async {
    // Send to printer service
    RegistrationServerApi().printDocuments(key, appSettings.printer);
  }

  @override
  Widget buildBottomSheet(BuildContext context) {
    return Text('Nothing special to show');
  }
}
