import 'package:realm/realm.dart';

import '/enums/scan_result.dart';
import '/models/activity.dart';
import '/models/activity_category.dart';
import '/models/scan_info.dart';
import '/models/access_check_result.dart';

class LocalDataStore {
  static final LocalDataStore _singleton = LocalDataStore._internal();

  late LocalConfiguration _config;
  late Realm _realm;

  factory LocalDataStore() {
    return _singleton;
  }

  LocalDataStore._internal() {
    _config = Configuration.local([
      ActivityCategory.schema,
      Activity.schema,
      ActivityParticipant.schema,
    ]);
    _realm = Realm(_config);
    /* on destroy?     
  realm.close();
  Realm.shutdown();
  */
  }

  List<ActivityCategory> getCategories() {
    var categories = _realm.all<ActivityCategory>();
    return categories.toList();
  }

  void storeCategories(List<ActivityCategory> categories) {
    _realm.write(() {
      _realm.addAll(categories, update: true);
    });
  }

  void upsertActivity(Activity data) {
    _realm.write(() {
      _realm.add(data, update: true);
    });
  }

  Activity? getActivity(int activityId) {
    try {
      return _realm.query<Activity>('id == \$0', [activityId]).first;
    } on Exception {
      return null;
    }
  }

  List<Activity> getActivities() {
    var list = _realm.all<Activity>();
    return list.toList();
  }

  void deleteActivity(Activity activity) {
    _realm.write(() {
      _realm.delete(activity);
    });
  }

  AccessCheckResult checkAccess(ScanInfo data) {
    AccessCheckResult result;
    try {
      var participation = _realm
          .query<ActivityParticipant>('activityId == \$0 && personKey == \$1', [
        data.activityId,
        data.personKey,
      ]).first;
      if (participation.scanTime == null) {
        result = AccessCheckResult(scanResult: ScanResult.pass);
      } else {
        result = AccessCheckResult(
          scanResult: ScanResult.check,
          prevScanTime: participation.scanTime,
        );
      }
      // write (new) scan time
      _realm.write(() {
        participation.scanTime = data.scanTime;
        _realm.add(participation, update: true);
      });
    } on Exception {
      result = AccessCheckResult(scanResult: ScanResult.deny);
    }
    return result;
  }

  AccessCheckResult queryAccess(ScanInfo info) {
    try {
      var participant = _realm.query<ActivityParticipant>(
        'activity.id == \$0 && personKey = \$1 LIMIT(1)',
        [info.activityId, info.personKey],
      ).first;
      if (participant.scanTime == null) {
        _realm.write(() {
          participant.scanTime = info.scanTime;
          _realm.add<ActivityParticipant>(participant, update: true);
        });
        return AccessCheckResult(
          scanResult: ScanResult.pass,
        );
      }
      return AccessCheckResult(
        scanResult: ScanResult.check,
        prevScanTime: participant.scanTime,
      );
    } on StateError {
      return AccessCheckResult(
        scanResult: ScanResult.deny,
      );
    }
  }

  void addScanInfo(ScanInfo info) {
    _realm.write(() {
      _realm.add(info);
    });
  }

  ScanInfo? getScanInfo() {
    try {
      return _realm.query<ScanInfo>('SORT(scanTime ASC) LIMIT(1)').first;
    } on Exception {
      return null;
    }
  }

  void removeScanInfo(ScanInfo info) {
    try {
      _realm.write(() {
        _realm.delete(info);
      });
    } on Exception {
      // log?
    }
  }
}
