import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/data/data_manager.dart';
import '/pages/scan.dart';
import '/scanning/registration_scan_handler.dart';

class RegistrationSetupPage extends StatelessWidget {
  void _startScanning(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ScanPage(handler: RegistrationScanHandler()),
        settings: RouteSettings(
          name: (ScanPage).toString() + (RegistrationScanHandler).toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<DataManager>(
        builder: (context, dataManager, child) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Select printer'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Select printer"),
          ),
        ),
      ),
    );
  }
}
