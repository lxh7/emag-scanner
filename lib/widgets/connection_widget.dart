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
            padding: const EdgeInsets.all(10.00),
            margin: const EdgeInsets.only(bottom: 10.00),
            color: dataManager.apiConnectionState.color,
            child: Row(children: [
              Container(
                margin: const EdgeInsets.only(right: 6.00),
                child: const Icon(Icons.info, color: Colors.white),
              ), // icon for error message
              Text(dataManager.apiConnectionState.displayMessage,
                  style: const TextStyle(color: Colors.white)),
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
}
