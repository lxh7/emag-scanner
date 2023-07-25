import 'package:logger/logger.dart';

Logger getLogger(String className) {
  return Logger(
    printer: PrettyPrinter(printTime: true, noBoxingByDefault: true),
  );
}
