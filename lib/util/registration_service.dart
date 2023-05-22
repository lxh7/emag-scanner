import 'dart:async';
import 'dart:io';
import 'dart:convert' show utf8;
import 'package:dio/io.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:udp/udp.dart';
import 'package:badge_api/badge_api.dart';

import '/logging/logging.dart';
import '/app_settings.dart';

class RegistrationService {
  late Logger _logger;

  // Query: Where is the Badge printing service?;
  static const String sDiscover = ':BADG:DISC:';
  // response will be in the form :BADG:DISC:<scheme>:<port>:

  static bool _discoveryDone = false;
  late UDP _udpClient;
  late Timer _udpTimer;
  Completer<bool>? _discoveryCompleter;
  static String? _apiUrl;
  static BadgeApi? _badgeApi;

  RegistrationService() {
    _logger = getLogger(runtimeType.toString());
    if (!_discoveryDone) {
      discover();
    }
  }

  Future discover() async {
    _discoveryDone = false;
    _badgeApi = null;
    var settings = AppSettings();

    if (_discoveryCompleter == null) {
      _discoveryCompleter = Completer<bool>();

      // create a UDP instance
      _udpClient = await UDP.bind(Endpoint.any(port: Port.any));

      // setup listener
      var packetStream = _udpClient.asStream();
      packetStream.listen(_packetReceived);
      _udpTimer = Timer(const Duration(seconds: 5), _udpTimeOut);

      // send our discovery message as a broadcast endpoint to the service port
      await _udpClient.send(utf8.encode(sDiscover),
          Endpoint.broadcast(port: Port(settings.updSendPort)));
      _logger.d('UDP: > $sDiscover');
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
      _logger.d('UDP: < $response');
      if (response.startsWith(sDiscover)) {
        var serverAddress = datagram.address;
        var parts = response.split(':');
        // first element will be empty as our respose starts with :
        var dataReceived = false;
        try {
          var serverScheme = parts[3];
          var serverPort = int.parse(parts[4]);
          var host = serverAddress.address;
          _apiUrl = '$serverScheme://$host:$serverPort';
          // make sure it is used in the next API call
          _badgeApi = null;
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
    return _apiUrl != null;
  }

  Future<BadgeApi> _getBadgeApi(var token) async {
    if (_badgeApi == null) {
      _badgeApi = BadgeApi(basePathOverride: _apiUrl);
      // Load our Self Signed Certificate to allow LAN HTTPS
      await _loadSelfSignedCertificate(
          _badgeApi!.dio.httpClientAdapter as IOHttpClientAdapter);
      _badgeApi!.dio.options.receiveTimeout =
          const Duration(seconds: 15); // a bit more relaxed
    }
    // Set the (refreshed) token for authentication.
    _badgeApi!.setBearerAuth('Bearer', token);
    return _badgeApi!;
  }

  Future<List<String>> getPrinters(String token) async {
    if (await _serverFound()) {
      var badgeApi = await _getBadgeApi(token);
      var printers = await badgeApi.getPrintersApi().printersGet();
      return printers.data!.toList();
    }
    return List<String>.empty();
  }

  Future printDocuments(
      String token, String personKey, String printerName) async {
    if (await _serverFound()) {
      var badgeApi = await _getBadgeApi(token);
      var dto = PrintRequestDTOBuilder();
      dto.personKey = personKey;
      dto.printerName = printerName;
      var response =
          await badgeApi.getPrintApi().printPost(printRequestDTO: dto.build());
      if (response.statusCode! >= 300) {
        _logger.w('${response.statusMessage} - ${response.statusMessage}');
      }
    }
  }

  Future _loadSelfSignedCertificate(
      IOHttpClientAdapter httpClientAdapter) async {
    ByteData rootCACert = await rootBundle.load('assets/ca.crt');
    ByteData serverCert = await rootBundle.load('assets/self.crt');
    ByteData serverKey = await rootBundle.load('assets/self.key');
    httpClientAdapter.onHttpClientCreate = (client) {
      // this code will silently accept all certificates
      // client.badCertificateCallback =
      //     (X509Certificate cert, String host, int port) => true;
      // HttpClient httpClient = HttpClient();
      SecurityContext context = SecurityContext(withTrustedRoots: true);
      context.setTrustedCertificatesBytes(rootCACert.buffer.asUint8List());
      context.useCertificateChainBytes(serverCert.buffer.asUint8List());
      context.usePrivateKeyBytes(serverKey.buffer.asUint8List());
      HttpClient httpClient = HttpClient(context: context);
      return httpClient;
    };
  }
}
