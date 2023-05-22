import 'package:test/test.dart';
import 'package:print_api/print_api.dart';


/// tests for PrintersApi
void main() {
  final instance = PrintApi().getPrintersApi();

  group(PrintersApi, () {
    //Future<BuiltList<String>> printersGet() async
    test('test printersGet', () async {
      // TODO
    });

  });
}
