import 'dart:async';

import '/data/backend_data_store.dart';
import '/data/local_data_store.dart';

class DequeueScanInfo {
  int _retryCount = 0;

  late LocalDataStore _local;
  late BackendDataStore _backend;

  DequeueScanInfo(LocalDataStore local, BackendDataStore backend) {
    _local = local;
    _backend = backend;
  }

  Future<void> run() async {
    try {
      var item = _local.getScanInfo();
      while (item != null) {
        // send to backend
        await _backend.queryAccessAsync(
          item.activityId,
          item.personKey,
          item.scanTime,
        );
        _local.removeScanInfo(item);
      }
    } on Exception {
      // something went wrong, try again later
      _retryCount++;
      if (_retryCount <= 6) {
        Timer(Duration(seconds: 10), run);
      }
    }
  }
}
