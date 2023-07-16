import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/data/data_manager.dart';
import '/models/domain.dart';

class GoodiesShowPage extends StatefulWidget {
  const GoodiesShowPage({super.key});

  @override
  State<GoodiesShowPage> createState() => _GoodiesShowPageState();
}

class _GoodiesShowPageState extends State<GoodiesShowPage> {
  late Person? _person;
  late List<Participation> _goodies;
  late HashSet<int>? _selectedGoodies;
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  bool _getGoodieEnabled(Participation p) {
    return p.scanTime == null; // TODO: expand with paid / reserved checks
  }

  bool _getGoodieSelected(Participation p) {
    return _selectedGoodies!.contains(p.activityId);
  }

  void _setGoodieSelected(Participation p, bool? value) {
    setState(() {
      if (value == true) {
        _selectedGoodies!.add(p.activityId);
      } else {
        _selectedGoodies!.remove(p.activityId);
      }
    });
  }

  String _getGoodieInfo(Participation p) {
    var buffer = StringBuffer();
    _addGoodieOption(p.activity?.question1, p.answer1, buffer);
    _addGoodieOption(p.activity?.question2, p.answer2, buffer);
    _addGoodieOption(p.activity?.question3, p.answer3, buffer);
    if (p.scanTime != null) {
      buffer.write('Handed out on ${_formatter.format(p.scanTime!)}');
    }
    // TODO: expand with paid / reserved info
    return buffer.toString();
  }

  void _addGoodieOption(String? question, String? answer, StringBuffer buffer) {
    if (question?.isEmpty == true) return;
    if (answer?.isEmpty == true) return;
    buffer.writeln('$question: $answer');
  }

  Future _saveGoodies(BuildContext context) async {
    var dataManager = DataManager(context);
    var now = DateTime.now();
    for (int activityId in _selectedGoodies!) {
      var info = ScanInfo(activityId, _person!.key, now);
      await dataManager.checkAccess(info);
    }
  }

  @override
  Widget build(BuildContext context) {
    // initialize at first build
    if (_person == null) {
      // Extract the person from the current ModalRoute.
      _person = ModalRoute.of(context)!.settings.arguments as Person;
      final filterCategories = DataManager(context).getGoodieCategories();
      _goodies = _person!.participations
          .where((c) => filterCategories.contains(c.activity?.categoryId))
          .toList();
      _goodies.sort(_compareGoodies);
      _selectedGoodies = HashSet<int>.from(
          _goodies.where((p) => (p.scanTime != null)).map((p) => p.activityId));
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Ordered goodies'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: [
              Text(_person!.name),
              const Text(
                  'Check all goodies that are handed over to the participant. Don\'t forget to click the "Save and close" button below to store this!'),
              ..._buildGoodieUI(),
              ElevatedButton(
                child: Text(
                    (_goodies.isEmpty == true) ? 'Close' : 'Save and close'),
                onPressed: () async {
                  Navigator.pop(context);
                  await _saveGoodies(context);
                },
              ),
            ], // children
          ),
        ),
      ),
    );
  }

  int _compareGoodies(Participation p1, Participation p2) {
    var result = p1.activity!.categoryId.compareTo(p2.activity!.categoryId);
    if (result == 0) {
      result = p1.activityId.compareTo(p2.activityId);
    }
    return result;
  }

  _buildGoodieUI() {
    if (_goodies.isEmpty == true) {
      return const Text('No goodies reserved');
    }
    return ListView(
        shrinkWrap: true,
        primary: false,
        children: _goodies
            .map((p) => CheckboxListTile(
                  title: Text(p.activity!.name),
                  subtitle: Text(_getGoodieInfo(p)),
                  value: _getGoodieSelected(p),
                  enabled: _getGoodieEnabled(p),
                  onChanged: (bool? value) {
                    _setGoodieSelected(p, value);
                  },
                ))
            .toList());
  }
}
