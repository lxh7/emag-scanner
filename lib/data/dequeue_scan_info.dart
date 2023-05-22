import 'dart:async';

import '/data/backend_data_store.dart';
import '/data/local_data_store.dart';

class DequeueScanInfo {
  int _retryCount = 0;

  late LocalDataStore _local;
  late BackendDataStore _backend;  
  late Future<String> Function() _getAccessToken;

  DequeueScanInfo(
      LocalDataStore local, BackendDataStore backend, Future<String> Function() getAccessToken) {
    _local = local;
    _backend = backend;
    _getAccessToken = getAccessToken;
  }

  Future<void> run() async {
    try {
      var item = _local.getScanInfo();
      while (item != null) {
        // send to backend
        await _backend.queryAccessAsync(
          await _getAccessToken(),
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
        Timer(const Duration(seconds: 10), run);
      }
    }
  }
}
