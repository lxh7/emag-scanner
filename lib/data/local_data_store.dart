import 'package:logger/logger.dart';
import 'package:realm/realm.dart';

import '../logging/logging.dart';
import '/enums/scan_result.dart';
import '/models/activity.dart';
import '/models/activity_category.dart';
import '/models/scan_info.dart';
import '/models/access_check_result.dart';

class LocalDataStore {
  late LocalConfiguration _config;
  late Realm _realm;
  static late Logger _logger;

  LocalDataStore() {
    _config = Configuration.local([
      ActivityCategory.schema,
      Activity.schema,
      ActivityParticipant.schema,
      ScanInfo.schema,
    ]);
    _realm = Realm(_config);
    _logger = getLogger(runtimeType.toString());
  }

  // @override
  // dispose() {
  //   _realm.close();
  //   Realm.shutdown();
  //   super.dispose();
  // }

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
      var data = _realm.query<Activity>('id == \$0', [activityId]);
      if (data.isEmpty) {
        return null;
      }
      return data.first;
    } on Exception catch (ex) {
      _logger.e('Exception in getActivity on local store:', ex);
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
    } on Exception catch (ex) {
      _logger.e('Exception in checkAccess on local store:', ex);
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
    } on Exception catch (ex) {
      _logger.e('Exception in getScanInfo on local store:', ex);
      return null;
    }
  }

  void removeScanInfo(ScanInfo info) {
    try {
      _realm.write(() {
        _realm.delete(info);
      });
    } on Exception catch (ex) { 
      _logger.e('Exception in removeScanInfo on local store:', ex);
    }
  }
}
