import 'dart:ffi';

import 'package:emag_scanner/widgets/spinner.dart';
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

  _startScanning(BuildContext context, Activity activity) {
    _logger.i('Start scanning');
    Navigator.pushNamed(context, Routes.scan,
        arguments: ActivityScanHandler(activity));
  }

  _showParticipants(
      BuildContext context, DataManager dataManager, int activityId) {
    _logger.i('Show participants');
    dataManager.getActivity(activityId).then((activity) {
      Navigator.pushNamed(context, Routes.activityParticipants,
          arguments: activity);
    });
  }

  _selectOtherActivity(BuildContext context) {
    _logger.i('Select another activity');
    Navigator.pushNamed(context, Routes.activitySelect);
  }

  @override
  Widget build(BuildContext context) {
    _logger.d('Bulding ActivityConfirmPage');
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
            child: FutureBuilder<Activity?>(
                future: dataManager.getSelectedActivity(),
                builder: (context, snapshot) {
                  _logger.d('${snapshot.connectionState}');
                  if (snapshot.connectionState != ConnectionState.done) {
                    // while data is loading:
                    return const Center(
                      child: Spinner(),
                    );
                  } else {
                    // data loaded:
                    final activity = snapshot.data;
                    return ListView(children: [
                      if (activity == null) ...[
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
                          activity: activity,
                          tapAction: () => _startScanning(context, activity),
                          longPressAction: () =>
                              _showParticipants(context, dataManager, activity.id),
                          // trailingWidget: const Icon(Icons.refresh, size: 50),
                          // trailingAction: () => _refreshActivity(item),
                        )
                      ]
                    ]);
                  } // else
                }),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              child: const Center(
                child: Text('Select another activity'),
              ),
              onPressed: () => _selectOtherActivity(context),
            ),
          ),
        ),
      ),
    );
  }
}
