import 'package:realm/realm.dart';

part 'activity.g.dart';

// generate with: flutter pub run realm generate
@RealmModel()
class _Activity {
  @PrimaryKey()
  late int id;
  late int categoryId;
  late String name;
  late DateTime start;
  late DateTime end;
  late List<_ActivityParticipant> participants;
}

@RealmModel()
class _ActivityParticipant {
  @Backlink(#participants)
  late Iterable<_Activity> activity;
  @Indexed()
  late String personKey;
  late DateTime? scanTime;
}
