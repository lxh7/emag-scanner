import 'dart:async';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '/logging/logging.dart';
import '/data/data_manager.dart';
import '/enums/api_connection_state.dart';
import '/enums/scan_result.dart';
import '/scanning/base_scan_handler.dart';
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
    switch (newResult) {
      case ScanResult.none:
        // quiet and peaceful ...
        Vibrator.stopBuzzer();
        break;
      case ScanResult.pass:
        Vibrator.okBuzzer();
        if (scanMessage == '') {
          // auto reset status after a short while
          _timer = Timer(
            const Duration(milliseconds: 1500),
            () => setScanResult(ScanResult.none, ''),
          );
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
          // backgroundColor: Colors.orange,
          icon: Icons.question_mark,
        );
        break;
      case ScanResult.deny:
      case ScanResult.error:
        Vibrator.errorBuzzer();
        showDialog(
          'Not allowed',
          message,
          //backgroundColor: Colors.red,
          icon: Icons.block,
        );
        break;
    }
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
      onClose: _startScanning,
    );
  }

  void _stopScanning() {
    _torchEnabled = _cameraController.torchEnabled;
    _cameraController.stop();
  }

  void _startScanning() {
    setScanResult(ScanResult.none, '');
    _cameraController.start();
    if (_torchEnabled ^ _cameraController.torchEnabled) {
      _cameraController.toggleTorch();
    }
  }

  @override
  Widget build(BuildContext context) {
    late BaseScanHandler handler =
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
          title: Text(handler.getTitle()),
          centerTitle: subTitle != '',
          toolbarHeight: 80,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const <StretchMode>[
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
            ],
            centerTitle: true,
            title: Text(
              dataManager.apiConnectionState.displayMessage,
              textScaleFactor: 0.6,
            ),
          ),
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
              // color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: _cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      return const Icon(Icons.lightbulb, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.lightbulb,
                          color: Colors.yellowAccent);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => _cameraController.toggleTorch(),
            ),
          ],
        ),
        /*
        Note: DO NOT put anything else as the body, otherwise the preview window does not appear!
        */
        body: MobileScanner(
          controller: _cameraController,
          fit: BoxFit.contain,
          onDetect: (capture) =>
              handler.handleBarcodes(capture.barcodes),
          onScannerStarted: _scannerStarted,
        ),
        backgroundColor: scanResult.getColor(_theme.colorScheme.background),
        /*
        Note: DO NOT add a bottomNavigationBar, otherwise the preview window does not appear!
        */
        // bottomNavigationBar
      ),
    );
  }

  void _scannerStarted(MobileScannerArguments? arguments) {
    _logger.i('Scanner started: $arguments');
  }
}
