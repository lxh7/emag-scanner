import 'package:flutter/material.dart';

enum ApiConnectionState {
  none,
  authCheck, // connected to internet, authenticating
  authFail, // connected to internet, authentication failed, no token received
  backendCheck, // authenticated, trying to connect to backend
  backendFail, // authenticated, backend could not be reached
  full, // connected to backend, authenticated
}

extension ApiConnectionStateExtension on ApiConnectionState {
  String get displayMessage {
    switch (this) {
      case ApiConnectionState.none:
        return 'No internet connection available';
      case ApiConnectionState.authCheck:
        return 'Authenticating...';
      case ApiConnectionState.authFail:
        return 'Authentication failed (got no token)';
      case ApiConnectionState.backendCheck:
        return 'Checking connectivity to backend';
      case ApiConnectionState.backendFail:
        return 'Backend could not be reached';
      case ApiConnectionState.full:
        return 'Fully connected';
    }
  }

  Color get color {
    switch (this) {
      case ApiConnectionState.none:
      case ApiConnectionState.backendFail:
      case ApiConnectionState.authFail:
        return Colors.red;
      case ApiConnectionState.authCheck:
      case ApiConnectionState.backendCheck:
        return Colors.orange;
      case ApiConnectionState.full:
        return Colors.green;
    }
  }
}
