import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/util/routes.dart';
import '/data/data_manager.dart';
import '/scanning/registration_scan_handler.dart';
import '/util/registration_service.dart';
import '/widgets/connection_widget.dart';
import '/widgets/printer_tile.dart';
import '/widgets/spinner.dart';

class RegistrationSetupPage extends StatelessWidget {
  const RegistrationSetupPage({super.key});

  void _startScanning(BuildContext context,
      Future<String> Function() getTokenFunc, String printer) {
    Navigator.pushNamed(context, Routes.scan, arguments:  RegistrationScanHandler(getTokenFunc, printer));
  }

  @override
  Widget build(BuildContext context) {
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
                const Text('Select printer', textAlign: TextAlign.center),
                _getTokenWaiterWidget(
                    dataManager.getOauth2token, registrationService),
              ], // children
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<String?> _getTokenWaiterWidget(
      Future<String> Function() getTokenFunc,
      RegistrationService registrationService) {
    return FutureBuilder(
      future: getTokenFunc(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var token = snapshot.data;
          return _getPrintersWaiterWidget(
              registrationService, token, getTokenFunc);
        } else {
          return const Spinner();
        }
      },
    );
  }

  FutureBuilder<List<String>> _getPrintersWaiterWidget(
      RegistrationService registrationService,
      String? token,
      Future<String> Function() getTokenFunc) {
    return FutureBuilder(
      future: registrationService.getPrinters(token ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<String>? printers = snapshot.data;
          return _getPrintersWidgets(printers, context, getTokenFunc);
        } else {
          return const Spinner();
        }
      },
    );
  }

  Widget _getPrintersWidgets(List<String>? printers, BuildContext context,
      Future<String> Function() getTokenFunc) {
    if (printers?.isNotEmpty == true) {
      var result = ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ...printers!
              .map((item) => PrinterTile(
                    printer: item,
                    tapAction: () =>
                        _startScanning(context, getTokenFunc, item),
                  ))
              .toList()
        ],
      );
      return result;
    } else {
      return const Text('No printers found');
    }
  }
}
