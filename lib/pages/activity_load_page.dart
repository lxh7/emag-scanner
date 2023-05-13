import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/spinner.dart';
import '/data/data_manager.dart';
import '/models/activity.dart';
import '/models/activity_category.dart';
import '/widgets/activity_tile.dart';
import '/widgets/connection_widget.dart';

class ActivityLoadPage extends StatefulWidget {
  const ActivityLoadPage({super.key});

  @override
  State<ActivityLoadPage> createState() => _ActivityLoadPageState();
}

class _ActivityLoadPageState extends State<ActivityLoadPage> {
  ActivityCategory? _category;
  List<Activity>? _activities;

  // methods/functions

  Future _downloadActivityParticipantsAsync(Activity activity) async {
    var dataManager = context.read<DataManager>();
    activity = await dataManager.refreshActivityAsync(activity) ?? activity;
    dataManager.addStoredActivity(activity);
    dataManager.selectedActivity = activity;
  }

  Future<List<Activity>> _loadActivities() async {
    if (_category == null) {
      return List<Activity>.empty();
    }
    var dataManager = context.read<DataManager>();
    return await dataManager.getActivities(_category!);
  }

  // UI event handlers
  void _setFilterCategory(ActivityCategory value) {
    if (_category != value) {
      setState(() {
        _category = value;
        _activities = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var dataManager = context.read<DataManager>(); 
    return SafeArea(
      child: Scaffold(
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
          child: ListView(
            children: [
              ConnectionWidget.get(),
              Text('Load activities', textAlign: TextAlign.center),
              Text('Filter by category'),
              FutureBuilder(
                future: dataManager.getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<ActivityCategory>? categories = snapshot.data;
                    return _buildCategoryUI(categories);
                  } else {
                    return Spinner();
                  }
                },
              ),
              if (_category != null) ...[
                Text('Tap to load activity & participants'),
                _activities == null
                    ? FutureBuilder(
                        future: _loadActivities(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            _activities = snapshot.data;
                            _activities!.removeWhere((a) => a.end.isBefore(
                                DateTime.now().add(Duration(hours: -8))));
                            _activities!
                                .sort((a, b) => _compareActivities(a, b));
                            return _buildActivitiesUI();
                          } else {
                            return Spinner();
                          }
                        })
                    : _buildActivitiesUI()
              ],
            ], // children
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: Container(
        //   height: 50,
        //   margin: const EdgeInsets.all(10),
        //   child: ElevatedButton(
        //       child: Center(child: Text('Load diet buffet access')),
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute<void>(
        //                 builder: (context) => ActivityLoadPage(),
        //                 settings: RouteSettings(
        //                     name: (ActivityLoadPage).toString())));
        //       }),
        // ),
      ),
    );
  }

  _buildCategoryUI(List<ActivityCategory>? categories) {
    if (categories?.isEmpty == true) {
      _category = null;
      return Text('No categories loaded from server');
    }
    _category ??= categories!.first;
    return DropdownButton<ActivityCategory>(
      value: _category,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (ActivityCategory? value) {
        // This is called when the user selects an item.
        setState(() {
          _category = value!;
        });
      },
      items: categories!
          .map<DropdownMenuItem<ActivityCategory>>((ActivityCategory value) {
        return DropdownMenuItem<ActivityCategory>(
          value: value,
          child: Text(value.name),
          onTap: () => _setFilterCategory(value),
        );
      }).toList(),
    );
  }

  Widget _buildActivitiesUI() {
    if (_activities == null || _activities!.isEmpty) {
      return Text('No activities in this category');
    }
    return ListView(
      shrinkWrap: true,
      children: _activities!
          .map((item) => ActivityTile(
                activity: item,
                tapAction: () => _downloadActivityParticipantsAsync(item)
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
    result = a.end.compareTo(b.end);

    return result;
  }
}
