import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '/data/data_manager.dart';
import '/logging/logging.dart';
import '/models/domain.dart';
import '/scanning/activity_scan_handler.dart';
import '/util/routes.dart';
import '/widgets/activity_tile.dart';

class ActivityConfirmPage extends StatelessWidget {
  final Logger _logger = getLogger('ActivityConfirmPage');

  ActivityConfirmPage({super.key});

  _startScanning(BuildContext context) {
    _logger.i('Start scanning');
    Navigator.pushNamed(context, Routes.scan, arguments: ActivityScanHandler());
  }

  _showParticipants(BuildContext context, Activity activity) {
    _logger.i('Show particpants');
    DataManager(context).getActivity(activity.id).then((refreshedActivity) {
      Navigator.pushNamed(context, Routes.activityParticipants,
          arguments: refreshedActivity);
    });
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
                ] else ...[
                  const Center(
                    child: Text(
                        'Tap to start scanning participants for this activity'),
                  ),
                  ActivityTile(
                    activity: dataManager.selectedActivity!,
                    tapAction: () => _startScanning(context),
                    longPressAction: () => _showParticipants(
                        context, dataManager.selectedActivity!),
                    /*
                    trailingWidget: const Icon(Icons.refresh, size: 50),
                    trailingAction: () => _refreshActivity(item),
                    */
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
