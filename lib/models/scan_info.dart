import 'package:realm/realm.dart';

part 'scan_info.g.dart';

// generate with: flutter pub run realm generate
@RealmModel()
class _ScanInfo {
  late int activityId;
  late String personKey;
  @Indexed()
  late DateTime scanTime;
}
