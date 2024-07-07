import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '/logging/logging.dart';
import '/data/data_manager.dart';
import '/enums/api_connection_state.dart';
import '/enums/scan_result.dart';
import '/scanning/base_scan_handler.dart';
import '/util/routes.dart';
import '/util/my_dialog.dart';
import '/util/vibrator.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => ScanPageState();
}

class ScanPageState extends State<ScanPage> {
  late Logger _logger;
  late ThemeData _theme;
  late MobileScannerController _cameraController;
  late ScanResult scanResult = ScanResult.none;
  late String scanMessage = '';
  Timer? _timer;
  static bool _torchEnabled = false;
  /*
    Note: do not start/stop the camera too often, this may result in crashes/inresponsive bar code scanner on iOS and (older) Android devices.
    In stead, maintain a flag to process the (stream of) barcodes from the scanner or not (e.g. during the display of dialogs)
  */
  bool _pauzeBarcodes = false;

  ScanPageState() {
    _logger = getLogger(runtimeType.toString());
    _cameraController = MobileScannerController(
      autoStart: true,
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: _torchEnabled,
    );
  }

  void setScanResult(ScanResult newResult, String message) {
    _logger.i('Scan state set to $newResult with message "$message"');
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      scanResult = newResult;
      scanMessage = message;
    });
    _logger.d('setScanResult(): $newResult');
    switch (newResult) {
      case ScanResult.none:
        // quiet and peaceful ...
        Vibrator.stopBuzzer();
        break;
      case ScanResult.pass:
        Vibrator.okBuzzer();
        if (scanMessage == '') {
          // auto reset status after a short while
          _timer =
              Timer(const Duration(milliseconds: 1500), () => _startScanning());
        } else {
          showDialog(
            'Scan OK',
            message,
            backgroundColor: Colors.green,
            icon: Icons.question_mark,
          );
        }
        break;
      case ScanResult.check:
        Vibrator.warningBuzzer();
        showDialog(
          'Additional check needed',
          message,
          icon: Icons.question_mark,
        );
        break;
      case ScanResult.deny:
      case ScanResult.error:
        Vibrator.errorBuzzer();
        showDialog(
          'Not allowed',
          message,
          icon: Icons.block,
        );
        break;
    }
  }

  void showResultInAPage(String routeName, {Object? arguments}) {
    _stopScanning();
    Navigator.pushNamed(context, routeName, arguments: arguments)
        .then((Object? returnVal) {
      _logger.d('showResultInAPage returned');
      _startScanning();
    });
  }

  void showDialog(
    String caption,
    String message, {
    Color? backgroundColor,
    required IconData icon,
  }) {
    _stopScanning();
    MyDialog.showPopup(
      context,
      caption,
      message,
      backgroundColor: backgroundColor,
      icon: Icon(
        icon,
        color: Colors.black,
        size: 48.0,
      ),
      onClose: () {
        _logger.d('dialog closed');
        _startScanning();
      },
    );
  }

  void _stopScanning() {
    _logger.d('_stopScanning()');
    _torchEnabled = _cameraController.torchEnabled;
    _logger.d('pauzing reception of barcodes');
    _pauzeBarcodes = true;
  }

  void _startScanning() {
    _logger.d('_startScanning()');
    _timer?.cancel();
    _timer = null;
    setScanResult(ScanResult.none, '');
    _logger.d('starting reception of barcodes');
    _pauzeBarcodes = false;
  }

  @override
  Widget build(BuildContext context) {
    BaseScanHandler handler =
        ModalRoute.of(context)!.settings.arguments as BaseScanHandler;
    handler.page = this;
    _theme = Theme.of(context);
    var dataManager = context.watch<DataManager>();
    var subTitle = handler.getSubTitle();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          handler.getTitle(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        centerTitle: subTitle != '',
        toolbarHeight: 80,
        bottom: subTitle != ''
            ? PreferredSize(
                preferredSize: Size.zero,
                child: Text(
                  subTitle,
                  style: TextStyle(color: _theme.secondaryHeaderColor),
                ),
              )
            : null,
        actions: [
          Icon(
            Icons.network_wifi,
            color: dataManager.apiConnectionState.color,
          ),
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: _cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.lightbulb, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.lightbulb, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: _cameraController.toggleTorch,
          ),
          IconButton(
            icon: const Icon(Icons.help),
            tooltip: 'Help',
            onPressed: () {
              Navigator.pushNamed(context, Routes.help);
            },
          )
        ],
        backgroundColor: scanResult.getColor(_theme.colorScheme.primary),
      ),
      // Note: DO NOT put any container or such as the body, otherwise the preview window does not appear!
      body: MobileScanner(
        controller: _cameraController,
        fit: BoxFit.cover,
        onDetect: (BarcodeCapture capture) async {
          await _barcodeDetected(capture, handler);
        },
      ),
      // Note: DO NOT add a bottomNavigationBar, otherwise the preview window does not appear!
      backgroundColor: scanResult.getColor(_theme.colorScheme.background),
    ));
  }

  Future _barcodeDetected(
      BarcodeCapture capture, BaseScanHandler handler) async {
    if (!_pauzeBarcodes) {
      _stopScanning();
      await handler
          .handleBarcodes(capture.barcodes)
          .then((value) => _startScanning());
    }
  }
}
