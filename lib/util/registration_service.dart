import 'dart:async';
import 'dart:io';
import 'dart:convert' show utf8;
import 'package:udp/udp.dart';
import 'package:emagscan/apis/registration/lib/api.dart';

import '/app_settings.dart';

class RegistrationService {
  // Where is the Badge printing service?;
  static const String sDiscover = ':BADG:DISC:';
  // response will be in the form :BADG:DISC:<scheme>:<port>:
  static bool _discoveryDone = false;
  static InternetAddress? _serverAddress;
  static String _serverScheme = "http";
  static int _serverPort = 80;

  late UDP _udpClient;
  late Timer _udpTimer;
  Completer<bool>? _discoveryCompleter;

  RegistrationService() {
    if (!_discoveryDone) {
      discover();
    }
  }

  Future discover() async {
    _discoveryDone = false;
    var settings = AppSettings();

    if (_discoveryCompleter == null) {
      _discoveryCompleter = Completer<bool>();

      // create a UDP instance
      _udpClient = await UDP.bind(Endpoint.any(port: Port.any));

      // setup listener
      var packetStream = _udpClient.asStream();
      packetStream.listen(_packetReceived);
      _udpTimer = Timer(Duration(seconds: 5), _udpTimeOut);

      // send our discovery message as a broadcast endpoint to the service port
      await _udpClient.send(utf8.encode(sDiscover),
          Endpoint.broadcast(port: Port(settings.updSendPort)));
      print('UDP: > $sDiscover');
    }
    return _discoveryCompleter!.future;
  }

  void _discoveryComplete(bool result) {
    _discoveryDone = true;
    if (_discoveryCompleter != null) {
      _discoveryCompleter!.complete(result);
    }
    _udpTimer.cancel();
    _udpClient.close();
  }

  void _udpTimeOut() {
    // did not receive response in time...
    _discoveryComplete(false);
  }

  void _packetReceived(Datagram? datagram) {
    if (datagram != null) {
      var response = utf8.decode(datagram.data);
      print('UDP: < $response');
      if (response.startsWith(sDiscover)) {
        _serverAddress = datagram.address;
        var parts = response.split(':');
        // first element will be empty as our respose starts with :
        var dataReceived = false;
        try {
          _serverScheme = parts[3];
          _serverPort = int.parse(parts[4]);
          dataReceived = true;
        } catch (_) {
          // too bad?
        }
        _discoveryComplete(dataReceived);
      }
    }
  }

  Future<bool> _serverFound() async {
    if (!_discoveryDone) {
      await discover();
    }
    return _serverAddress != null;
  }

  void _ensureApiConfigured(String token) {
    // did we ever initiate our defaultApiClient?
    if (defaultApiClient.basePath == '' ||
        defaultApiClient.basePath == 'http://localhost') {
      var host = _serverAddress!.address;
      defaultApiClient = ApiClient(
        basePath: '$_serverScheme://$host:$_serverPort',
        authentication: OAuth(accessToken: token),
      );
    }
  }

  Future<List<String>> getPrinters(String token) async {
    if (await _serverFound()) {
      _ensureApiConfigured(token);
      var printers = await PrintersApi().printersGet();
      if (printers != null) {
        return printers;
      }
    }
    return List<String>.empty();
  }

  Future printDocuments(String token, String key, String printer) async {
    if (await _serverFound()) {
      _ensureApiConfigured(token);
      var request = PrintRequestDTO(personKey: key, printerName: printer);
      await PrintApi().printPost(printRequestDTO: request);
    }
  }
}
