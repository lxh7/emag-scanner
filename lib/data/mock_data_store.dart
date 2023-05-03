// mock some data for the UI
import 'package:scan/models/activity_category.dart';
import 'package:scan/models/activity.dart';

class MockDataStore {
  late List<ActivityCategory> _categories;
  late List<Activity> _activities;

  MockDataStore() {
    _categories = List<ActivityCategory>.from([
      ActivityCategory(8, 'Meals'),
      ActivityCategory(5, 'EMAG'),
      ActivityCategory(16, 'Activities'),
      ActivityCategory(7, 'Rotterdam'),
      ActivityCategory(6, 'Escape Rooms'),
      ActivityCategory(10, 'Fun & games'),
      ActivityCategory(9, 'Tours'),
      ActivityCategory(11, 'Art & science'),
      ActivityCategory(12, 'Family'),
      ActivityCategory(13, 'Water'),
      ActivityCategory(14, 'Lectures'),
      ActivityCategory(15, 'Workshops'),
    ]);

    _activities = List<Activity>.empty(growable: true);
    _activities.add(Activity(1, 8, "Ice breaker", DateTime(2023, 8, 2, 18, 0),
        DateTime(2023, 8, 2, 22, 0)));
    _activities.add(Activity(
      2,
      9,
      "Dordrecht",
      DateTime(2023, 8, 3, 9, 0),
      DateTime(2023, 8, 3, 17, 30),
    ));
    _activities.add(Activity(
      3,
      9,
      "Delft",
      DateTime(2023, 8, 4, 9, 0),
      DateTime(2023, 8, 4, 16, 30),
    ));
    _activities.add(Activity(
      4,
      10,
      "Euromast",
      DateTime(2023, 8, 3, 14, 0),
      DateTime(2023, 8, 3, 16, 0),
    ));
    _activities.add(Activity(
      5,
      7,
      "City walk",
      DateTime(2023, 8, 4, 9, 15),
      DateTime(2023, 8, 4, 11, 30),
    ));
    _activities.add(Activity(
      6,
      8,
      "Gala dinner",
      DateTime(2023, 8, 5, 19, 0),
      DateTime(2023, 8, 5, 23, 0),
    ));
  }

  Future<List<ActivityCategory>> getCategories() async {
    return _categories;
  }

  Future<List<Activity>> getActivities(int? categoryId) async {
    var now = DateTime.now();
    var result = _activities
        .where((element) => element.end.isAfter(now.add(Duration(hours: 2))))
        .toList();
    if (categoryId != null) {
      result =
          result.where((element) => element.categoryId == categoryId).toList();
    }
    result.sort((a, b) => a.start.compareTo(b.start));
    return result;
  }

}
