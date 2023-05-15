import 'package:test/test.dart';
import 'package:emag_badge_printer/emag_badge_printer.dart';


/// tests for PrintApi
void main() {
  final instance = EmagBadgePrinter().getPrintApi();

  group(PrintApi, () {
    //Future printPost({ PrintRequestDTO printRequestDTO }) async
    test('test printPost', () async {
      // TODO
    });

  });
}
