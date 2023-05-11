import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '/enums/scan_result.dart';
import '/scanning/base_scan_handler.dart';
import '/util/vibrator.dart';
import '/widgets/connection_widget.dart';

class ScanPage extends StatefulWidget {
  final BaseScanHandler handler;

  ScanPage({super.key, required this.handler});

  @override
  State<ScanPage> createState() => ScanPageState();
}

class ScanPageState extends State<ScanPage> {
  late ScanResult scanResult = ScanResult.none;
  late String scanMessage = '';
  Timer? _timer;

  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  void setScanResult(ScanResult newResult, String message) {
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
        break;
      case ScanResult.pass:
        Vibrator.okBuzzer();
        // auto reset status after a short while
        _timer = Timer(
          Duration(milliseconds: 1500),
          () => setScanResult(ScanResult.none, ''),
        );
        break;
      case ScanResult.check:
        Vibrator.warningBuzzer();
        showModalBottomSheet(
            context: context, builder: widget.handler.buildBottomSheet);
        break;
      case ScanResult.deny:
      case ScanResult.error:
        Vibrator.errorBuzzer();
        showModalBottomSheet(
            context: context, builder: widget.handler.buildBottomSheet);
        break;
    }
  }

  Color getActionColor(context) {
    switch (scanResult) {
      case ScanResult.none:
        return Theme.of(context).colorScheme.background;
      case ScanResult.pass:
        return Colors.green;
      case ScanResult.check:
        return Colors.orange;
      case ScanResult.deny:
      case ScanResult.error:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.handler.page = this;
    var subTitle = widget.handler.getSubTitle();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(widget.handler.getTitle()),
          centerTitle: subTitle != '',
          bottom: subTitle != ''
              ? PreferredSize(
                  preferredSize: Size.zero,
                  child: Text(
                    subTitle,
                    style: TextStyle(color: Colors.yellowAccent),
                  ),
                )
              : null,
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            // IconButton(
            //   color: Colors.white,
            //   icon: ValueListenableBuilder(
            //     valueListenable: cameraController.cameraFacingState,
            //     builder: (context, state, child) {
            //       switch (state) {
            //         case CameraFacing.front:
            //           return const Icon(Icons.camera_front);
            //         case CameraFacing.back:
            //           return const Icon(Icons.camera_rear);
            //       }
            //     },
            //   ),
            //   iconSize: 32.0,
            //   onPressed: () => cameraController.switchCamera(),
            // ),
          ],
        ),
        body: MobileScanner(
          fit: BoxFit.contain,
          controller: cameraController,
          onDetect: (capture) =>
              widget.handler.handleBarcodes(capture.barcodes),
        ),
        backgroundColor: getActionColor(context),
        bottomNavigationBar: ConnectionWidget.get(),
      ),
    );
  }
}
