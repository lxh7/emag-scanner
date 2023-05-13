import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/data/backend_data_store.dart';
import '/data/data_manager.dart';
import 'scan_page.dart';
import '/scanning/registration_scan_handler.dart';
import '/util/registration_service.dart';
import '/widgets/connection_widget.dart';
import '/widgets/printer_tile.dart';
import '/widgets/spinner.dart';

class RegistrationSetupPage extends StatelessWidget {
  void _startScanning(
      BuildContext context, BackendDataStore backend, String printer) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ScanPage(
          handler: RegistrationScanHandler(
            getAccessToken: backend.getAccessToken,
            printer: printer,
          ),
        ),
        settings: RouteSettings(
          name: (ScanPage).toString() + (RegistrationScanHandler).toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var backend = context.read<BackendDataStore>();
    var registrationService = RegistrationService();

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
            title: const Text('Prepare for registration'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                ConnectionWidget.get(),
                Text('Select printer', textAlign: TextAlign.center),
                _getTokenWaiterWidget(backend, registrationService),
              ], // children
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<String?> _getTokenWaiterWidget(
      BackendDataStore backend, RegistrationService registrationService) {
    return FutureBuilder(
      future: backend.getAccessToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var token = snapshot.data;
          return _getPrintersWaiterWidget(registrationService, token, backend);
        } else {
          return Spinner();
        }
      },
    );
  }

  FutureBuilder<List<String>> _getPrintersWaiterWidget(
      RegistrationService registrationService,
      String? token,
      BackendDataStore backend) {
    return FutureBuilder(
      future: registrationService.getPrinters(token ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<String>? printers = snapshot.data;
          return _getPrintersWidgets(printers, context, backend);
        } else {
          return Spinner();
        }
      },
    );
  }

  Widget _getPrintersWidgets(
      List<String>? printers, BuildContext context, BackendDataStore backend) {
    if (printers?.isNotEmpty == true) {
      var result = ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          ...printers!
              .map((item) => PrinterTile(
                    printer: item,
                    tapAction: () => _startScanning(context, backend, item),
                  ))
              .toList()
        ],
      );
      return result;
    } else {
      return Text('No printers found');
    }
  }
}
