// mock some data for the UI
import 'package:emag_scanner/models/domain.dart';

class MockDataStore {
  late List<Category> _categories;
  late List<Activity> _activities;

  MockDataStore() {
    _categories = List<Category>.from([
      Category(8, 'Meals', 0),
      Category(5, 'EMAG', 0),
      Category(16, 'Activities', 1),
      Category(7, 'Rotterdam', 1),
      Category(6, 'Escape Rooms', 1),
      Category(10, 'Fun & games', 1),
      Category(9, 'Tours', 1),
      Category(11, 'Art & science', 1),
      Category(12, 'Family', 1),
      Category(13, 'Water', 1),
      Category(14, 'Lectures', 1),
      Category(15, 'Workshops', 1),
    ]);

    _activities = List<Activity>.empty(growable: true);
    _activities.add(Activity(1, 8, 'Ice breaker', DateTime(2023, 8, 2, 18, 0),
        DateTime(2023, 8, 2, 22, 0)));
    _activities.add(Activity(
      2,
      9,
      'Dordrecht',
      DateTime(2023, 8, 3, 9, 0),
      DateTime(2023, 8, 3, 17, 30),
    ));
    _activities.add(Activity(
      3,
      9,
      'Delft',
      DateTime(2023, 8, 4, 9, 0),
      DateTime(2023, 8, 4, 16, 30),
    ));
    _activities.add(Activity(
      4,
      10,
      'Euromast',
      DateTime(2023, 8, 3, 14, 0),
      DateTime(2023, 8, 3, 16, 0),
    ));
    _activities.add(Activity(
      5,
      7,
      'City walk',
      DateTime(2023, 8, 4, 9, 15),
      DateTime(2023, 8, 4, 11, 30),
    ));
    _activities.add(Activity(
      6,
      8,
      'Gala dinner',
      DateTime(2023, 8, 5, 19, 0),
      DateTime(2023, 8, 5, 23, 0),
    ));
  }

  Future<List<Category>> getCategories() async {
    return _categories;
  }

  Future<List<Activity>> getActivities(int? categoryId) async {
    var now = DateTime.now();
    var result = _activities
        .where(
            (element) => element.end.isAfter(now.add(const Duration(hours: 2))))
        .toList();
    if (categoryId != null) {
      result =
          result.where((element) => element.categoryId == categoryId).toList();
    }
    result.sort((a, b) => a.start.compareTo(b.start));
    return result;
  }
}
