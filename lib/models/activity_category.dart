import 'package:realm/realm.dart';

part 'activity_category.g.dart';

@RealmModel()
class _ActivityCategory {
  @PrimaryKey()
  @Indexed()
  late int id;
  late String name;
}
