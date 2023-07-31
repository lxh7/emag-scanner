import 'dart:convert';
import 'package:emag_scanner/util/dto_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/widgets/spinner.dart';

class ProgrammePage extends StatefulWidget {
  const ProgrammePage({super.key});

  @override
  State<ProgrammePage> createState() => _ProgrammePageState();
}

class StaticActivity {
  String title;
  String category;
  DateTime start;
  DateTime end;
  String location;
  String coordinates;

  StaticActivity.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '?',
        category = json['category'] ?? '?',
        start = DtoHelper.convertDate(json['datum'], DateTime(2023))!,
        end = DtoHelper.convertDate(json['datum_end'], DateTime(2023))!,
        location = json['place'] ?? '?',
        coordinates = json['meet_gps'] ?? '?';
}

class _ProgrammePageState extends State<ProgrammePage> {
  String? _category;
  List<String>? _categories;
  List<StaticActivity>? _allActivities;
  List<StaticActivity>? _activities;

  // UI event handlers
  void _setFilterCategory(String value) {
    if (_category != value) {
      setState(() {
        _category = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Programme overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: _loadData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: [
                  const Text('Programme overview', textAlign: TextAlign.center),
                  const Text('Filter by category'),
                  _buildCategoryUI(),
                  _buildActivitiesUI()
                ],
                // children
              );
            } else {
              return const Spinner();
            }
          },
        ),
      ),
    );
  }

  _buildCategoryUI() {
    if (_categories?.isNotEmpty == false) {
      _category = null;
      return const Text('No categories loaded');
    }
    _category ??= _categories!.first;
    return DropdownButton<String>(
      value: _category,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          _category = value!;
        });
      },
      items: _categories!.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          onTap: () => _setFilterCategory(value),
        );
      }).toList(),
    );
  }

  Widget _buildActivitiesUI() {
    const int maxTitleLen = 37;

    if (_activities == null || _activities!.isEmpty) {
      return const Text('No activities in this category');
    }
    return ListView(
      primary: false,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: _activities!
          .map(
            (activity) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                title: Text(activity.title.length > maxTitleLen
                    // ignore: prefer_interpolation_to_compose_strings
                    ? activity.title.substring(0, maxTitleLen) + '...'
                    : activity.title),
                subtitle: Text(activity.location! +'\n'+
                    DateFormat('dd-MM-yyyy HH:mm - ').format(activity.start) +
                        DateFormat('HH:mm').format(activity.end)),
                isThreeLine: true,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Future _loadData(BuildContext context) async {
    if (_allActivities == null) {
      var jsonString = await DefaultAssetBundle.of(context)
          .loadString('assets/activities.json');
      List<dynamic> activitiesList = jsonDecode(jsonString);
      // convert json to objects
      _allActivities =
          activitiesList.map((e) => StaticActivity.fromJson(e)).toList();
      // read categories from this, make distinct using a set
      _categories =
          _allActivities!.map((activity) => activity.category).toSet().toList();
      _categories!.sort();
      // select a category
      _category ??= _categories?.first;
    }
    // filter _activities on this category
    _activities = _allActivities!
        .where((activity) => activity.category == _category)
        .toList();
    _activities!.sort(_compareActivities);
  }

  int _compareActivities(StaticActivity a, StaticActivity b) {
    int result = a.start.compareTo(b.start);
    if (result != 0) {
      return result;
    }
    result = a.title.compareTo(b.title);
    return result;
  }
}
