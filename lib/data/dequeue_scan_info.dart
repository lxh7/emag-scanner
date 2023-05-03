import 'dart:async';

import '/app_state.dart';
import '/data/backend_data_store.dart';
import '/data/local_data_store.dart';
import '/enums/api_connection_state.dart';

class DequeueScanInfo {
  Future run() async {
    var appState = AppState();
    var local = LocalDataStore();
    var backend = BackendDataStore();
    try {
      var item = local.getScanInfo();
      while (item != null) {
        if (appState.connectionState != ApiConnectionState.full) {
          return; // stop dequeueing for now
        }
        // send to backend
        await backend.queryAccess(
          item.activityId,
          item.personKey,
          item.scanTime,
        );
        local.removeScanInfo(item);
      }
    } on Exception {
      // something went wrong, try again later
      Timer(Duration(seconds: 10), run);
    }
  }
}
