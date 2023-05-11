import 'dart:io';
import 'dart:convert';

import 'package:network_info_plus/network_info_plus.dart';

class RegistrationServerApi {
  static const String sFindMessage = 'Where is the EMAG Registration service?';
  static const String sServerResponseKey =
      'It\'s me, the EMAG Registration service';
  static int udpPort = 7891;
  static int tcpPort = 7891;
  static InternetAddress? serverAddress;

  RegistrationServerApi() {
    findServer();
  }

  void findServer() {
    NetworkInfo().getWifiBroadcast().then(
      (value) {
        if (value != null) {
          var broadcastAddress = InternetAddress(value);
          RawDatagramSocket.bind(InternetAddress.anyIPv4, udpPort).then(
            (RawDatagramSocket udpSocket) {
              // setup listener
              udpSocket.broadcastEnabled = true;
              udpSocket.listen((e) {
                Datagram? dg = udpSocket.receive();
                if (dg != null) {
                  print("received ${dg.data}");
                  if (dg.data == utf8.encode(sFindMessage)) {
                    serverAddress = dg.address;
                  }
                }
              });
              // send query
              List<int> data = utf8.encode(sServerResponseKey);
              udpSocket.send(data, broadcastAddress, 8889);
            },
          );
        }
      },
    );
  }

  Future<List<String>> getPrinters() async {
    // TODO: implement getPrinters
    return List<String>.empty();
  }

  Future printDocuments(String key, String printer) async {
    // TODO: implement printDocuments
  }
}
