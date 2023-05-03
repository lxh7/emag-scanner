import '/enums/scan_result.dart';

class AccessCheckResult {
  final ScanResult scanResult;
  final DateTime? prevScanTime;
  final String message;

  AccessCheckResult({
    this.scanResult = ScanResult.none,
    this.prevScanTime,
    this.message = '',
  });
}
