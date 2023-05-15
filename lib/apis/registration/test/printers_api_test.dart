import 'package:test/test.dart';
import 'package:emag_badge_printer/emag_badge_printer.dart';


/// tests for PrintersApi
void main() {
  final instance = EmagBadgePrinter().getPrintersApi();

  group(PrintersApi, () {
    //Future<BuiltList<String>> printersGet() async
    test('test printersGet', () async {
      // TODO
    });

  });
}
