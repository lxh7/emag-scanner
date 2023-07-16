import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/data/data_manager.dart';
import '/models/domain.dart';
import '/scanning/goodies_scan_handler.dart';
import '/util/my_dialog.dart';
import '/util/routes.dart';
import '/widgets/connection_widget.dart';
import '/widgets/spinner.dart';

class GoodiesSetupPage extends StatefulWidget {
  const GoodiesSetupPage({super.key});

  @override
  State<GoodiesSetupPage> createState() => _GoodiesSetupPageState();
}

class _GoodiesSetupPageState extends State<GoodiesSetupPage> {
  List<Category>? _categories;
  HashSet<int>? _selectedCategories;

  bool _getCategorySelected(Category category) {
    return _selectedCategories!.contains(category.id);
  }

  void _setCategorySelected(Category category, bool? value) {
    setState(() {
      if (value == true) {
        _selectedCategories!.add(category.id);
      } else {
        _selectedCategories!.remove(category.id);
      }
    });
  }

  void _startScanning(BuildContext context, DataManager dataManager) {
    if (_selectedCategories == null || _selectedCategories!.isEmpty) {
      MyDialog.showError(context, 'Select at least one (1) category for goodies');
      return;
    }
    dataManager.setGoodieCategories(_selectedCategories!.toList());
    Navigator.pushNamed(context, Routes.scan,
        arguments: GoodiesScanHandler(_selectedCategories!));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<DataManager>(
        builder: (context, dataManager, child) {
          _selectedCategories ??=
              HashSet<int>.from(dataManager.getGoodieCategories());
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('Select goodies categories'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  ConnectionWidget.get(),
                  const Text('Select the categories of goodies'),
                  _categories == null
                      ? FutureBuilder(
                          future: dataManager.getCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              _categories = snapshot.data;
                              return _buildCategoryUI(_categories);
                            } else {
                              return const Spinner();
                            }
                          },
                        )
                      : _buildCategoryUI(_categories),
                  ElevatedButton(
                    child: const Text('Start scanning for goodies'),
                    onPressed: () {
                      _startScanning(context, dataManager);
                    },
                  ),
                ], // children
              ),
            ),
          );
        },
      ),
    );
  }

  _buildCategoryUI(List<Category>? categories) {
    if (categories?.isEmpty == true) {
      return const Text('No categories loaded from server');
    }
    return ListView(
        shrinkWrap: true,
        primary: false,
        children: categories!
            .map((c) => CheckboxListTile(
                  title: Text(c.name),
                  value: _getCategorySelected(c),
                  onChanged: (bool? value) {
                    _setCategorySelected(c, value);
                  },
                ))
            .toList());
  }
}
