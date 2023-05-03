import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan/data/data_manager.dart';
import 'package:scan/models/activity.dart';

import '../enums/api_connection_state.dart';
import '../widgets/connection_widget.dart';
import '/app_state.dart';
import '/widgets/activity_tile.dart';
import 'activity_load.dart';

class ActivitySelectPage extends StatefulWidget {
  const ActivitySelectPage({super.key});

  @override
  State<ActivitySelectPage> createState() => _ActivitySelectPageState();
}

class _ActivitySelectPageState extends State<ActivitySelectPage> {
  late AppState _appState;

  _addActivity() {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => ActivityLoadPage(),
          settings: RouteSettings(name: (ActivityLoadPage).toString()),
        ));
  }

  _selectActivity(Activity activity) {
    _appState.activeActivity = activity;
    Navigator.pop(context);
  }

  _deleteActivity(Activity activity) {
    DataManager.removeStoredActivity(activity);
    setState(() {});
  }

  Future _refreshActivity(Activity activity) async {
    await DataManager.refreshActivity(activity);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _appState = context.watch<AppState>();
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
          child: ListView(
            children: [
              ConnectionWidget.get(),
              Text('Select activity to scan for. Long press = delete.',
                  textAlign: TextAlign.center),
              if (_appState.connectionState == ApiConnectionState.full) ...[
                Text(
                    'Tap the refresh symbol to refresh the list of participants from the server to this device (for offline scanning)',
                    textAlign: TextAlign.center),
              ],
              ...DataManager.storedActivities()
                  .map((item) => ActivityTile(
                        activity: item,
                        tapAction: () => _selectActivity(item),
                        longPressAction: () => _deleteActivity(item),
                        trailingWidget: Icon(Icons.refresh, size: 50),
                        trailingAction: () => _refreshActivity(item),
                      ))
                  .toList(),
            ], // children
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addActivity(),
          tooltip: 'Add more activities',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.blue,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              children: <Widget>[
                // IconButton(
                //   tooltip: 'Open navigation menu',
                //   icon: const Icon(Icons.menu),
                //   onPressed: () {},
                // ),
                // IconButton(
                //   tooltip: 'Search',
                //   icon: const Icon(Icons.search),
                //   onPressed: () {},
                // ),
                // IconButton(
                //   tooltip: 'Favorite',
                //   icon: const Icon(Icons.favorite),
                //   onPressed: () {},
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
