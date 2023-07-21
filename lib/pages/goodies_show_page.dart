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
  late ThemeData _theme;
  Person? _person;
  late List<Participation> _goodies;
  late HashSet<int> _selectedGoodies;
  final DateFormat _formatter = DateFormat('yyyy-MM-dd hh:mm');

  bool _getGoodieEnabled(Participation p) {
    if (!p.paid) return false;
    if (p.waitlisted) return false;
    return true;
  }

  bool _getGoodieSelected(Participation p) {
    return _selectedGoodies.contains(p.activityId);
  }

  void _setGoodieSelected(Participation p, bool? value) {
    setState(() {
      if (value == true) {
        _selectedGoodies.add(p.activityId);
      } else {
        _selectedGoodies.remove(p.activityId);
      }
    });
  }

  Widget _getGoodieInfo(Participation p) {
    List<TableRow> rows = List<TableRow>.empty(growable: true);
    _addOptionRow(p.activity?.question1, p.answer1, rows);
    _addOptionRow(p.activity?.question2, p.answer2, rows);
    _addOptionRow(p.activity?.question3, p.answer3, rows);
    if (p.scanTime != null) {
      rows.add(TableRow(children: [
        Text('Handed out on ${_formatter.format(p.scanTime!.toLocal())}'),
        const Text(''),
      ]));
    }
    if (!p.paid) {
      rows.add(TableRow(children: [
        Text(
          'Not paid!',
          style: TextStyle(
            color: _theme.colorScheme.error,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Text(''),
      ]));
    }
    if (p.waitlisted) {
      rows.add(TableRow(children: [
        Text(
          'On wait list!',
          style: TextStyle(
            color: _theme.colorScheme.error,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Text(''),
      ]));
    }
    return Table(
      // border: TableBorder.(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(3.0),
        1: FlexColumnWidth(1.0),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: rows,
    );
  }

  void _addOptionRow(String? question, String? answer, List<TableRow> rows) {
    if (question?.isEmpty == true || answer?.isEmpty == true) return;
    rows.add(TableRow(children: [
      Text(
        question!,
        style: TextStyle(color: _theme.colorScheme.secondary),
      ),
      Text(
        answer!,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _theme.colorScheme.primary,
        ),
      )
    ]));
  }

  Color _getGoodieColor(Participation p) {
    if (p.scanTime != null) return const Color.fromARGB(255, 90, 5, 5);
    if (!p.paid) return const Color.fromARGB(255, 255, 0, 0);
    if (p.waitlisted) return const Color.fromARGB(255, 255, 164, 103);
    // all good, allow to hand out
    return const Color.fromARGB(64, 121, 255, 197);
  }

  void _saveGoodies() {
    if (_selectedGoodies.isNotEmpty) {
      var dataManager = DataManager(context);
      var now = DateTime.now().toUtc();
      for (int activityId in _selectedGoodies) {
        var info = ScanInfo(activityId, _person!.key, now);
        Future.wait([dataManager.checkAccess(info)]);
      }
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
    _theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
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
              Text(
                _person!.name,
                style: const TextStyle(
                  color: Color.fromARGB(255, 18, 18, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Check all goodies that are handed over to the participant. Don\'t forget to click the "Save and close" button below to store this!',
                style: TextStyle(
                  //color: Color.fromARGB(255, 18, 18, 255),
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              _buildGoodieUI(),
              ElevatedButton(
                child: Text(
                    (_goodies.isEmpty == true) ? 'Close' : 'Save and close'),
                onPressed: () {
                  _saveGoodies();
                  Navigator.pop(context);
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

  Widget _buildGoodieUI() {
    if (_goodies.isEmpty == true) {
      return const Text(
        'No goodies reserved',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      );
    }
    return ListView(
        shrinkWrap: true,
        primary: false,
        children: _goodies
            .map((p) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: _getGoodieColor(p),
                    width: 5,
                  )),
                  child: CheckboxListTile(
                    title: Text(p.activity!.name),
                    subtitle: _getGoodieInfo(p),
                    // selectedTileColor: Colors.amber,
                    value: _getGoodieSelected(p),
                    enabled: _getGoodieEnabled(p),
                    onChanged: (bool? value) {
                      _setGoodieSelected(p, value);
                    },
                  ),
                ))
            .toList());
  }
}
