import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan/app_settings.dart';
import 'package:scan/app_state.dart';
import 'package:scan/data/data_manager.dart';
import 'package:scan/widgets/connection_widget.dart';

import '../models/activity.dart';
import '../models/activity_category.dart';
import '../widgets/activity_tile.dart';

class ActivityLoadPage extends StatefulWidget {
  const ActivityLoadPage({super.key});

  @override
  State<ActivityLoadPage> createState() => _ActivityLoadPageState();
}

class _ActivityLoadPageState extends State<ActivityLoadPage> {
  List<ActivityCategory>? _categories;
  ActivityCategory? _category;
  List<Activity>? _activities;

  // methods/functions

  void _downloadActivityParticipants(Activity activity) {
    DataManager.addStoredActivity(activity, refreshParticipants: true);
    AppSettings.instance.lastActivityId = activity.id;
    AppState().activeActivity = activity;
    Navigator.pop(context);
  }

  Future<List<Activity>> _loadActivities() async {
    if (_category == null) {
      return List<Activity>.empty();
    }
    return await DataManager.getActivities(_category!);
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
    /*_appState = */ context.watch<AppState>();
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
              _categories == null
                  ? FutureBuilder(
                      future: DataManager.getCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          _categories = snapshot.data;
                          return _buildCategoryUI();
                        } else {
                          return _spinner();
                        }
                      },
                    )
                  : _buildCategoryUI(),
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
                            return _spinner();
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

  _buildCategoryUI() {
    if (_categories?.isEmpty == true) {
      _category = null;
      return Text('No categories loaded from server');
    }
    _category ??= _categories!.first;
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
      items: _categories!
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
                tapAction: () => _downloadActivityParticipants(item),
              ))
          .toList(),
    );
  }

  Widget _spinner() {
    return Center(
      child: SizedBox(
        height: 25.0,
        width: 25.0,
        child: CircularProgressIndicator(),
      ),
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
