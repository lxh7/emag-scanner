import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '/util/routes.dart';
import '/logging/logging.dart';
import '/data/data_manager.dart';
import '/widgets/activity_tile.dart';
import '/scanning/activity_scan_handler.dart';

class ActivityConfirmPage extends StatelessWidget {
  final Logger _logger = getLogger('ActivityConfirmPage');

  ActivityConfirmPage({super.key});

  _startScanning(BuildContext context) {
    _logger.i('Start scanning');
    Navigator.pushNamed(context, Routes.scan, arguments: ActivityScanHandler());
  }

  _selectOtherActivity(BuildContext context) {
    _logger.i('Select other activity');
    Navigator.pushNamed(context, Routes.activitySelect);
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
            title: const Text('Confirm activity'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                if (dataManager.selectedActivity == null) ...[
                  const Center(
                    child: Text(
                        'No activity is selected. Please select one first'),
                  ),
                ]
                else ...[
                  const Center(
                    child: Text(
                        'Tap to start scanning participants for this activity'),
                  ),
                  ActivityTile(
                    activity: dataManager.selectedActivity!,
                    tapAction: () => _startScanning(context),
                  )
                ]
              ], // children
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: Center(
                child: Text(dataManager.selectedActivity == null
                    ? 'Select activity'
                    : 'Select another activity'),
              ),
              onPressed: () => _selectOtherActivity(context),
            ),
          ),
        ),
      ),
    );
  }
}
