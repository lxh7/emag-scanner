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
            color: Colors.red,
            child: Row(children: [
              Container(
                margin: EdgeInsets.only(right: 6.00),
                child: Icon(Icons.info, color: Colors.white),
              ), // icon for error message
              Text(_getConnectionStateText(dataManager.apiConnectionState),
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

  static String _getConnectionStateText(ApiConnectionState connectionState) {
    switch (connectionState) {
      case ApiConnectionState.none:
        return "No Internet Connection Available";
      case ApiConnectionState.internet:
        return "Cannot access the server";
      case ApiConnectionState.backend:
        return "Cannot authenticate";
      case ApiConnectionState.full:
        return "Fully connected";
    }
  }
}
