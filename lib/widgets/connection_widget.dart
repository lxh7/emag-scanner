import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/data/data_manager.dart';
import '/enums/api_connection_state.dart';

class ConnectionWidget {
  static Widget get() {
    return Consumer<DataManager>(
      builder: (context, dataManager, child) {
        //error message widget.
        if (dataManager.apiConnectionState != ApiConnectionState.full) {
          //if not fully connected show error message box
          return Container(
            padding: EdgeInsets.all(10.00),
            margin: EdgeInsets.only(bottom: 10.00),
            color: getConnectionStateColor(dataManager.apiConnectionState),
            child: Row(children: [
              Container(
                margin: EdgeInsets.only(right: 6.00),
                child: Icon(Icons.info, color: Colors.white),
              ), // icon for error message
              Text(getConnectionStateText(dataManager.apiConnectionState),
                  style: TextStyle(color: Colors.white)),
              //show error message text
            ]),
          );
        } else {
          return Container();
          //if error is false, return empty container.
        }
      },
    );
  }

  static String getConnectionStateText(ApiConnectionState connectionState) {
    switch (connectionState) {
      case ApiConnectionState.none:
        return "No internet connection available";
      case ApiConnectionState.backendCheck:
        return 'Checking connectivity to backend';
      case ApiConnectionState.backendFail:
        return 'Backend cout not be reached';
      case ApiConnectionState.authCheck:
        return 'Authenticating...';
      case ApiConnectionState.authFail:
        return 'Authentication failed';
      case ApiConnectionState.full:
        return 'Fully connected';
    }
  }

  static Color getConnectionStateColor(ApiConnectionState connectionState) {
    switch (connectionState) {
      case ApiConnectionState.none:
      case ApiConnectionState.backendFail:
      case ApiConnectionState.authFail:
        return Colors.red;
      case ApiConnectionState.backendCheck:
      case ApiConnectionState.authCheck:
        return Colors.orange;
      case ApiConnectionState.full:
        return Colors.green;
    }
  }
}
