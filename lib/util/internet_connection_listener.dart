import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnectionListener extends ChangeNotifier {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _connected = false;

  bool get connected {
    return _connected;
  }

  set connected(bool value) {
    if (_connected != value) {
      _connected = value;
      notifyListeners();
    }
  }

  InternetConnectionListener() {
    var connectivity = Connectivity();
    connectivity
        .checkConnectivity()
        .then((value) => _handleConnectivityChanged(value));
    _connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Be sure to cancel subscription after we're done
  @override
  dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  _handleConnectivityChanged(ConnectivityResult value) {
    connected = (value != ConnectivityResult.none);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult value) async {
    _handleConnectivityChanged(value);
  }
}