import 'package:logger/logger.dart';
import 'package:realm/realm.dart';

import '/util/my_formats.dart';
import '/enums/scan_result.dart';
import '/logging/logging.dart';
import '/models/domain.dart';

class LocalDataStore {
  late LocalConfiguration _config;
  late Realm _realm;
  static late Logger _logger;

  LocalDataStore() {
    _config = Configuration.local(
      [
        Category.schema,
        Activity.schema,
        Participation.schema,
        Person.schema,
        ScanInfo.schema,
      ],
      schemaVersion: 3,
      // shouldDeleteIfMigrationNeeded: true,
    );
    _realm = Realm(_config);
    _logger = getLogger(runtimeType.toString());
  }

  // @override
  // dispose() {
  //   _realm.close();
  //   Realm.shutdown();
  //   super.dispose();
  // }

  void clear() {
    _logger.d('Removing all objects in local store');
    _realm.write(() {
      _realm.deleteAll<Category>();
      _realm.deleteAll<Activity>();
      _realm.deleteAll<Participation>();
      _realm.deleteAll<Person>();
      _realm.deleteAll<ScanInfo>();
    });
  }

  int objectCount() {
    _logger.d('Counting objects in local store');
    var count = _realm.all<Category>().length +
        _realm.all<Activity>().length +
        _realm.all<Participation>().length +
        _realm.all<Person>().length +
        _realm.all<ScanInfo>().length;
    _logger.v('$count');
    return count;
  }

  List<Category> getCategories() {
    var categories = _realm.all<Category>();
    return categories.toList();
  }

  void storeCategories(List<Category> categories) {
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
      // var result = _realm.query<Activity>('id == \$0', [activityId]);
      var result = _realm.find<Activity>(activityId);
      return result;
      // if (result.isEmpty) {
      //   return null;
      // }
      // return result.first;
    } on Exception catch (ex) {
      _logger.e('Exception in LocalDataStore.getActivity()', ex);
      return null;
    }
  }

  List<Activity> getActivities() {
    var list = _realm.all<Activity>();
    return list.toList();
  }

  void deleteActivity(Activity activity) {
    _realm.write(() {
      // var activityParticipants = _realm.query<Participation>(
      //   'activityId == \$0',
      //   [activity.id],
      // );
      _realm.deleteMany(activity.participations);
      var parts = _realm.query<Participation>(
        'activityId == \$0',
        [activity.id],
      );
      _realm.deleteMany(parts);
      _realm.delete(activity);
    });
  }

  AccessCheckResult queryAccess(ScanInfo info) {
    AccessCheckResult result = AccessCheckResult(scanResult: ScanResult.error);
    Participation participation;
    try {
      // get the item from the store
      var realmResults = _realm.query<Participation>(
        'activityId == \$0 && personKey = \$1 LIMIT(1)',
        [info.activityId, info.personKey],
      );
      if (realmResults.isEmpty) {
        // no item in store, i.e. person is not registered on activity
        result.scanResult = ScanResult.deny;
        result.message = 'Not registered';
      } else {
        // found, person is participant
        // update local storage
        participation = realmResults.first;
        // check paid / waitlisted
        if (!participation.paid) {
          result.scanResult = ScanResult.deny;
          result.message = 'Not paid';
        } else if (participation.waitlisted) {
          result.scanResult = ScanResult.deny;
          result.message = 'On wait list';
        } else {
          // check scan time
          if (participation.scanTime == null) {
            // first scan
            result.scanResult = ScanResult.pass;
            result.message = 'OK';
          } else {
            // subsequent scan
            result.scanResult = ScanResult.check;
            result.message =
                'Scanned earlier: ${MyFormats.dateTime.format(participation.scanTime!.toLocal())}';
            if (result.prevScanTime == null ||
                DateTime.now()
                        .toUtc()
                        .difference(result.prevScanTime!)
                        .inMinutes >=
                    15) {
              result.prevScanTime = participation.scanTime;
            }
          }
        }
        // update local storage
        _realm.write(() {
          participation.scanTime = info.scanTime;
          _realm.add<Participation>(participation, update: true);
        });
      }
    } on StateError catch (ex) {
      _logger.e('Error in LocalDataStore.queryAccess()', ex);
      result.message = 'Error in LocalDataStore.queryAccess(): ${ex.message}';
    }
    return result;
  }

  void queueScanInfo(ScanInfo info) {
    _logger.d('Adding ScanInfo to queue');
    _realm.write(() {
      _realm.add<ScanInfo>(info);
    });
  }

  ScanInfo? getScanInfo() {
    try {
      _logger.d('Checking ScanInfo queue');
      // oldest first
      var realmResults =
          _realm.query<ScanInfo>('TRUEPREDICATE SORT(scanTime ASC) LIMIT(1)');
      if (realmResults.isEmpty) {
        _logger.d('ScanInfo queue is empty');
        return null;
      }
      return realmResults.first;
    } on Exception catch (ex) {
      _logger.e('Exception in LocalDataStore.getScanInfo()', ex);
      return null;
    }
  }

  void removeScanInfo(ScanInfo info) {
    _logger.d('Removing ScanInfo from queue');
    try {
      _realm.write(() {
        _realm.delete(info);
      });
    } on Exception catch (ex) {
      _logger.e('Exception in removeScanInfo on local store', ex);
    }
  }
}
