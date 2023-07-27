import 'package:emag_scanner/enums/api_connection_state.dart';
import 'package:emag_scanner/enums/scan_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/spinner.dart';
import '/data/data_manager.dart';
import '/models/domain.dart';
import '/widgets/activity_tile.dart';

class ActivityLoadPage extends StatefulWidget {
  const ActivityLoadPage({super.key});

  @override
  State<ActivityLoadPage> createState() => _ActivityLoadPageState();
}

class _ActivityLoadPageState extends State<ActivityLoadPage> {
  Category? _category;
  List<Activity>? _activities;

  // methods/functions

  Future _downloadParticipationsAsync(Activity activity) async {
    var dataManager = context.read<DataManager>();
    activity = await dataManager.refreshActivityAsync(activity) ?? activity;
    dataManager.addStoredActivity(activity);
    // dataManager.selectedActivity = activity;
  }

  Future<List<Activity>> _loadActivities() async {
    if (_category == null) {
      return List<Activity>.empty();
    }
    var dataManager = context.read<DataManager>();
    return await dataManager.getActivities(_category!);
  }

  // UI event handlers
  void _setFilterCategory(Category value) {
    if (_category != value) {
      setState(() {
        _category = value;
        _activities = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(builder: (context, dataManager, child) {
      final storedActivityIds =
          dataManager.getStoredActivities().map((e) => e.id).toList();
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Load activity'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: (dataManager.apiConnectionState != ApiConnectionState.full)
              ? const Text('No connection to the data store')
              : ListView(
                  children: [
                    const Text('Load activities', textAlign: TextAlign.center),
                    const Text('Filter by category'),
                    FutureBuilder(
                      future: dataManager.getCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          List<Category>? categories = snapshot.data;
                          return _buildCategoryUI(categories);
                        } else {
                          return const Spinner();
                        }
                      },
                    ),
                    if (_category != null) ...[
                      const Text('Tap to load activity & participants'),
                      _activities == null
                          ? FutureBuilder(
                              future: _loadActivities(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  _activities =
                                      _filterAndSortActivities(snapshot.data);
                                  return _buildActivitiesUI(storedActivityIds);
                                } else {
                                  return const Spinner();
                                }
                              })
                          : _buildActivitiesUI(storedActivityIds)
                    ],
                  ], // children
                ),
        ),
      );
    });
  }

  _buildCategoryUI(List<Category>? categories) {
    if (categories?.isNotEmpty == false) {
      _category = null;
      return const Text('No categories loaded from server');
    }
    // filter on categories with Activities
    var filteredList = categories!
        .where((c) =>
            c.scanFunction == ScanFunctionEnum.scan ||
            c.scanFunction == ScanFunctionEnum.activity)
        .toList();
    _category ??= filteredList.first;
    return DropdownButton<Category>(
      value: _category,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (Category? value) {
        // This is called when the user selects an item.
        setState(() {
          _category = value!;
        });
      },
      items: filteredList.map<DropdownMenuItem<Category>>((Category value) {
        return DropdownMenuItem<Category>(
          value: value,
          child: Text(value.name),
          onTap: () => _setFilterCategory(value),
        );
      }).toList(),
    );
  }

  List<Activity> _filterAndSortActivities(List<Activity>? data) {
    // don't show old activities, older than 8 hours
    var cutOffDate = DateTime.now().add(const Duration(hours: -8));
    var result = data;
    result!.removeWhere((a) =>
        (a.end.isBefore(cutOffDate)) ||
        (a.scanFunction != ScanFunctionEnum.activity &&
            a.category?.scanFunction != ScanFunctionEnum.activity));
    result.sort((a, b) => _compareActivities(a, b));
    return result;
  }

  Widget _buildActivitiesUI(List<int> storedActivityIds) {
    if (_activities == null || _activities!.isEmpty) {
      return const Text('No activities in this category');
    }
    return ListView(
      primary: false,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: _activities!
          .map((item) => ActivityTile(
                activity: item,
                enabled: !storedActivityIds.contains(item.id),
                tapAction: () => _downloadParticipationsAsync(item)
                    .then((value) => Navigator.pop(context)),
              ))
          .toList(),
    );
  }

  int _compareActivities(Activity a, Activity b) {
    int result = a.start.compareTo(b.start);
    if (result != 0) {
      return result;
    }
    result = a.name.compareTo(b.name);

    return result;
  }
}
