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
      // const String partId4 = 'defg4567';
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
      activity.participations.add(Participation(activityId, partId1));
      activity.participations.add(Participation(activityId, partId2));
      activity.participations.add(Participation(activityId, partId3));
      local.upsertActivity(activity);
      expectCount += 4;
      count = local.objectCount();
      assert(count == expectCount);

      // check access (as if person is scanned)
      // first scan
      var scanTime1 = DateTime.now();
      var info1 = ScanInfo(activityId, partId1, scanTime1);
      var result = local.queryAccess(info1);
      assert(result.scanResult == ScanResult.pass);
      assert(result.prevScanTime == null);
      local.queueScanInfo(info1);
      expectCount++;
      // second scan
      var scanTime2 = DateTime.now();
      var info2 = ScanInfo(activityId, partId1, scanTime2);
      result = local.queryAccess(info2);
      assert(result.scanResult == ScanResult.check);
      assert(result.prevScanTime?.millisecondsSinceEpoch ==
          scanTime1.millisecondsSinceEpoch);
      local.queueScanInfo(info2);
      expectCount++;

      // unregistered person scan
      var scanTime3 = DateTime.now();
      var info3 = ScanInfo(activityId, 'xxxxxxxxxx', scanTime3);
      result = local.queryAccess(info3);
      assert(result.scanResult == ScanResult.deny);

      count = local.objectCount();
      assert(count == expectCount);

      // get oldest scan info from queue
      var scanInfoFromQueue = local.getScanInfo();
      assert(scanInfoFromQueue != null);
      assert(scanInfoFromQueue!.scanTime == scanTime1);

      local.removeScanInfo(scanInfoFromQueue!);
      expectCount--;
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
