import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/util/my_dialog.dart';
import '/util/routes.dart';
import '/data/data_manager.dart';
import '/models/domain.dart';
import '/widgets/activity_tile.dart';
import '/widgets/connection_widget.dart';

class ActivitySelectPage extends StatefulWidget {
  const ActivitySelectPage({super.key});

  @override
  State<ActivitySelectPage> createState() => _ActivitySelectPageState();
}

class _ActivitySelectPageState extends State<ActivitySelectPage> {
  late DataManager _dataManager;

  _addActivity() {
    Navigator.pushNamed(context, Routes.activityDownload);
  }

  _selectActivity(Activity activity) {
    Navigator.pop(context);
    _dataManager.selectedActivity = activity;
  }

  _deleteActivity(Activity activity) async {
    var delete = await MyDialog.confirmAsync(context,
        'Do you want to remove the info about \'${activity.name}\' from your device?');
    if (delete) {
      _dataManager.removeStoredActivity(activity);
      setState(() {});
    }
  }

  Future _refreshActivity(Activity activity) async {
    var freshActivity = await _dataManager.refreshActivityAsync(activity);
    if (freshActivity != null) {
      // ignore: use_build_context_synchronously
      MyDialog.showInfo(
          context, 'Refreshed activity data and participation from server');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _dataManager = Provider.of<DataManager>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Select activity'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Consumer<DataManager>(builder: (context, dataManager, child) {
              return ListView(
                children: [
                  ConnectionWidget.get(),
                  Text(
                      _dataManager.storedActivities.isEmpty
                          ? 'Please load activites first'
                          : 'Select activity to scan for. Long press = delete.',
                      textAlign: TextAlign.center),
                  if (dataManager.isConnected) ...[
                    const Text(
                        'Tap the refresh symbol to refresh the list of participants from the server to this device (for offline scanning)',
                        textAlign: TextAlign.center),
                  ],
                  ..._dataManager.storedActivities
                      .map((item) => ActivityTile(
                            activity: item,
                            tapAction: () => _selectActivity(item),
                            longPressAction: () => _deleteActivity(item),
                            trailingWidget: const Icon(Icons.refresh, size: 50),
                            trailingAction: () => _refreshActivity(item),
                          ))
                      .toList(),
                ], // children
              );
            })),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addActivity(),
          tooltip: 'Add more activities',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.blue,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(),
          ),
        ),
      ),
    );
  }
}
