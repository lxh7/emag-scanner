import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:scan/data/dequeue_scan_info.dart';

import 'app_settings.dart';
import '/data/backend_data_store.dart';
import '/data/data_manager.dart';
import 'enums/api_connection_state.dart';
import 'models/activity.dart';

class AppState extends ChangeNotifier {
  ApiConnectionState _connectionState = ApiConnectionState.none;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  int _apiCheckInterval =
      1; // polling interval (seconds) trying to reach Backend
  Timer? _apiCheckTimer;

  Activity? _activeActivity;

  static AppState? _singleton;
  factory AppState() {
    _singleton ??= AppState._privateConstructor();
    return _singleton!;
  }

  AppState._privateConstructor() {
    DataManager.getActivity(AppSettings.instance.lastActivityId)
        .then((value) => activeActivity = value);

    var connectivity = Connectivity();
    connectivity
        .checkConnectivity()
        .then((value) => _handleConnectivityChanged(value));

    _connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Activity? get activeActivity {
    return _activeActivity;
  }

  set activeActivity(Activity? value) {
    _activeActivity = value;
    notifyListeners();
  }

  _handleConnectivityChanged(ConnectivityResult value) {
    if (value == ConnectivityResult.none) {
      connectionState = ApiConnectionState.none;
    } else {
      // check if we came from "no connection"
      if (connectionState == ApiConnectionState.none) {
        // gained connectivity
        connectionState = ApiConnectionState.internet;
      } else {
        // no actual change, maybe user switched from wifi to mobile
      }
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult value) async {
    _handleConnectivityChanged(value);
  }

  ApiConnectionState get connectionState {
    return _connectionState;
  }

  set connectionState(ApiConnectionState value) {
    if (_connectionState != value) {
      _connectionState = value;
      switch (connectionState) {
        case ApiConnectionState.none:
          // nothing to do
          break;
        case ApiConnectionState.internet:
          // start checking API connectivity
          _apiCheckInterval = 0;
          _checkApi();
          break;
        case ApiConnectionState.full:
          // start Scan Info dequeuing
          DequeueScanInfo().run();
          break;
      }
      notifyListeners();
    }
  }

  void _checkApi() {
    if (_apiCheckTimer != null) {
      _apiCheckTimer!.cancel();
      _apiCheckTimer = null;
    }
    try {
      BackendDataStore()
          .canReach()
          .then((_) => {
                // no exception means "can reach!"
                connectionState = ApiConnectionState.full
              })
          .onError((error, stackTrace) => {_retryCheckApi()});
    } catch (e) {
      _retryCheckApi();
    }
  }

  _retryCheckApi() {
    // keep trying while we have an internet connection
    if (connectionState == ApiConnectionState.internet) {
      if (_apiCheckInterval < 10) {
        _apiCheckInterval++;
      }
      _apiCheckTimer = Timer(Duration(seconds: _apiCheckInterval), _checkApi);
    }
  }

  // Be sure to cancel subscription after you are done
  @override
  dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
