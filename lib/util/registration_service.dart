import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:emagscan/apis/registration/lib/src/api/print_api.dart';
import 'package:emagscan/apis/registration/lib/src/model/print_request_dto.dart';
import 'package:flutter/services.dart';
import 'package:udp/udp.dart';
import 'dart:convert' show utf8;
import 'dart:js_interop';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:emagscan/apis/registration/lib/src/api.dart';
import 'package:emagscan/apis/registration/lib/src/api/printers_api.dart';

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

  static Dio? _dio;

  RegistrationService() {
    if (!_discoveryDone) {
      discover();
    }
  }

  Future discover() async {
    _discoveryDone = false;
    _dio = null;
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

  Future<Dio> _getDio() async {
    if (_dio == null) {
      var host = _serverAddress!.address;
      var options = BaseOptions(
          baseUrl: '$_serverScheme://$host:$_serverPort',
          responseType: ResponseType.json,
          connectTimeout: Duration(seconds: 3),
          receiveTimeout: Duration(seconds: 3),
          // ignore: missing_return
          validateStatus: (code) {
            if (code == null) return false;
            if (code >= 200) return true;
            return false;
          });
      _dio = Dio(options);

      ByteData rootCACertificate = await rootBundle.load("assets/ca.crt");
      ByteData serverCertificate = await rootBundle.load("assets/self.crt");
      ByteData serverPrivateKey = await rootBundle.load("assets/self.key");
      (_dio!.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (client) {
        // client.badCertificateCallback =
        //     (X509Certificate cert, String host, int port) => true;
        // HttpClient httpClient = HttpClient();
        SecurityContext context = SecurityContext(withTrustedRoots: true);
        context.setTrustedCertificatesBytes(
            rootCACertificate.buffer.asUint8List());
        context
            .useCertificateChainBytes(serverCertificate.buffer.asUint8List());
        context.usePrivateKeyBytes(serverPrivateKey.buffer.asUint8List());
        HttpClient httpClient = HttpClient(context: context);
        return httpClient;
      };
    }
    return _dio!;
  }

  Serializers _getSerializers({Serializer? serializer}) {
    var standardSerializers = Serializers();
    if (serializer != null) {
      var builder = standardSerializers.toBuilder();
      builder.add(serializer);
      return builder.build();
    }
    return standardSerializers;
  }

  Future<Openapi> _getOpenapi(String token, {Serializer? serializer}) async {
    var oa = Openapi(
      dio: await _getDio(),
      serializers: _getSerializers(serializer: serializer),
    );
    oa.setBearerAuth('Bearer', token);
    return oa;
  }

  Future<List<String>> getPrinters(String token) async {
    if (await _serverFound()) {
      var oa = await _getOpenapi(token);
      PrintersApi api = oa.getPrintersApi();
      var printers = await api.printersGet();
      if (!printers.isUndefinedOrNull) {
        return printers.data!.toList();
      }
    }
    return List<String>.empty();
  }

  Future printDocuments(
      String token, String personKey, String printerName) async {
    if (await _serverFound()) {
      var oa = await _getOpenapi(token, serializer: PrintRequestDTO.serializer);
      PrintApi api = oa.getPrintApi();
      var dto = PrintRequestDTOBuilder();
      dto.personKey = personKey;
      dto.printerName = printerName;
      var response = await api.printPost(printRequestDTO: dto.build());
      if (response.statusCode! >= 300) {
        print('${response.statusMessage} - @{response.statusMessage}');
      }
    }
  }
}
