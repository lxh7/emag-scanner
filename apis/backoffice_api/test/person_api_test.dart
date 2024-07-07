import 'package:test/test.dart';
import 'package:backoffice_api/backoffice_api.dart';


/// tests for PersonApi
void main() {
  final instance = BackofficeApi().getPersonApi();

  group(PersonApi, () {
    //Future<PersonDTO> getPerson(String participantId) async
    test('test getPerson', () async {
      // TODO
    });

  });
}
