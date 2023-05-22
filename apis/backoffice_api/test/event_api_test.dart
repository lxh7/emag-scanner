import 'package:test/test.dart';
import 'package:backoffice_api/backoffice_api.dart';


/// tests for EventApi
void main() {
  final instance = BackofficeApi().getEventApi();

  group(EventApi, () {
    //Future<EventDTO> getEvent(int eventId) async
    test('test getEvent', () async {
      // TODO
    });

    //Future<BuiltList<ParticipantDTO>> getParticipants(int eventId) async
    test('test getParticipants', () async {
      // TODO
    });

    //Future<BuiltList<EventDTO>> listEvents({ int categoryId }) async
    test('test listEvents', () async {
      // TODO
    });

    //Future<ScanTimeResponseDTO> patchParticipant(int eventId, String participantId, ScanTimeDTO scanTimeDTO) async
    test('test patchParticipant', () async {
      // TODO
    });

  });
}
