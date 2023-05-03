import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan/pages/activity_select.dart';

import '/app_state.dart';
import '/widgets/activity_tile.dart';
import '/scanning/activity_scan_handler.dart';
import 'scan.dart';

class ActivityConfirmPage extends StatelessWidget {
  _startScanning(BuildContext context) {
    print('start scanning');
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ScanPage(handler: ActivityScanHandler()),
        settings: RouteSettings(
          name: (ScanPage).toString() + (ActivityScanHandler).toString(),
        ),
      ),
    );
  }

  _selectOtherActivity(BuildContext context) {
    print('select other activity');
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ActivitySelectPage(),
        settings: RouteSettings(name: (ActivitySelectPage).toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Confirm activity'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              if (appState.activeActivity != null) ...[
                Center(
                  child: Text(
                      "Tap to start scanning participants for this activity"),
                ),
                ActivityTile(
                  activity: appState.activeActivity!,
                  tapAction: () => _startScanning(context),
                )
              ]
            ], // children
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 50,
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            child: Center(
              child: Text(appState.activeActivity == null
                  ? 'Select activity'
                  : 'Select another activity'),
            ),
            onPressed: () => _selectOtherActivity(context),
          ),
        ),
      ),
    );
  }
}
