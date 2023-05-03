import 'package:flutter/material.dart';

import '/app_state.dart';
import '/enums/api_connection_state.dart';

class ConnectionWidget {
  static Widget get() {
    var appState = AppState();
    //error message widget.
    if (appState.connectionState != ApiConnectionState.full) {
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
          Text(
              appState.connectionState == ApiConnectionState.internet
                  ? "Cannot access the server"
                  : "No Internet Connection Available",
              style: TextStyle(color: Colors.white)),
          //show error message text
        ]),
      );
    } else {
      return Container();
      //if error is false, return empty container.
    }
  }
}
