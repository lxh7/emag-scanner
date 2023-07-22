import 'package:emag_scanner/data/local_data_store.dart';
import 'package:emag_scanner/enums/scan_result.dart';
import 'package:emag_scanner/models/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('data test', () {
    test('local storage', () async {
      const int activityId = 123;
      const String partId1 = 'abcd1234';
      const String partId2 = 'bcde2345';
      const String partId3 = 'cdef3456';
      const String nonPartId1 = 'defg4567';
      int expectCount = 0;
      int count = 0;

      var local = LocalDataStore();
      // clear the store and check if we don't have any objects left
      local.clear();
      expectCount = 0;
      count = local.objectCount();
      assert(count == expectCount);

      // add an activity with some participants
      var activity = Activity(activityId, 1, 'test',
          DateTime(2023, 8, 2, 18, 0), DateTime(2023, 8, 2, 20, 0));
      activity.participations
          .add(Participation(activityId, partId1, true, false));
      activity.participations
          .add(Participation(activityId, partId2, true, true));
      activity.participations
          .add(Participation(activityId, partId3, false, false));
      local.upsertActivity(activity);
      expectCount += 4;
      count = local.objectCount();
      assert(count == expectCount);

      // check access (as if person is scanned)
      // first scan
      var scanTime1 = DateTime.now().toUtc();
      var info1 = ScanInfo(activityId, partId1, scanTime1);
      var result = local.queryAccess(info1);
      assert(result.scanResult == ScanResult.pass);
      assert(result.prevScanTime == null);
      local.queueScanInfo(info1);
      expectCount++;
      // second scan
      var scanTime = DateTime.now().toUtc();
      var info2 = ScanInfo(activityId, partId1, scanTime);
      result = local.queryAccess(info2);
      assert(result.scanResult == ScanResult.check);
      assert(result.prevScanTime?.millisecondsSinceEpoch ==
          scanTime1.millisecondsSinceEpoch);
      local.queueScanInfo(info2);
      expectCount++;

      // person who is on waitlist scan
      scanTime = DateTime.now().toUtc();
      var info3 = ScanInfo(activityId, partId2, scanTime);
      result = local.queryAccess(info3);
      assert(result.scanResult == ScanResult.deny);

      // person who has not paid scan
      scanTime = DateTime.now().toUtc();
      var info4 = ScanInfo(activityId, partId3, scanTime);
      result = local.queryAccess(info4);
      assert(result.scanResult == ScanResult.deny);

      // unregistered person scan
      scanTime = DateTime.now().toUtc();
      var info5 = ScanInfo(activityId, nonPartId1, scanTime);
      result = local.queryAccess(info5);
      assert(result.scanResult == ScanResult.deny);

      count = local.objectCount();
      assert(count == expectCount);

      // get oldest scan info from queue
      var scanInfoFromQueue = local.getScanInfo();
      assert(scanInfoFromQueue != null);
      assert(scanInfoFromQueue!.scanTime.millisecondsSinceEpoch ==
          scanTime1.millisecondsSinceEpoch);

      local.removeScanInfo(scanInfoFromQueue!);
      expectCount--;
      count = local.objectCount();
      assert(count == expectCount);

      var loadedActivity = local.getActivity(activityId);
      assert(loadedActivity != null);
      assert(loadedActivity!.participations.isNotEmpty);
      local.deleteActivity(loadedActivity!);
      expectCount -= 4;
      count = local.objectCount();
      assert(count == expectCount);

      local.clear();
      expectCount = 0;
      count = local.objectCount();
      assert(count == expectCount);
    });
    test('api', () async {
      // get categories
      // get events of categories
      // get event + participation
      // get event + participation + person details
      // get person + participation + event details

      // check access (as if person is scanned)
      // first scan
      // second scan
      // unregistered person scan
    });
    test('data manager - online', () async {
      // get an event
      // check access (as if person is scanned)
      // first scan
      // second scan
      // unregistered person scan
    });
    test('data manager - offline', () async {
      // get an event
      // check access (as if person is scanned)
      // first scan
      // second scan
      // unregistered person scan
    });
  });
}
