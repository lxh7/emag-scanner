import 'package:test/test.dart';
import 'package:backoffice_api/backoffice_api.dart';


/// tests for HealthApi
void main() {
  final instance = BackofficeApi().getHealthApi();

  group(HealthApi, () {
    //Future health() async
    test('test health', () async {
      // TODO
    });

  });
}
