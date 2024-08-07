import 'package:backoffice_api/backoffice_api.dart';
import 'package:logger/logger.dart';

import '/logging/logging.dart';
import '/enums/scan_result.dart';
import '/models/domain.dart';
import '/util/dto_helper.dart';

class BackendDataStore {
  static final BackendDataStore _instance = BackendDataStore._initialize();
  static late Logger _logger;

  factory BackendDataStore() {
    return _instance;
  }

  BackendDataStore._initialize() {
    _logger = getLogger(runtimeType.toString());
  }

  String _apiUrl = '';
  BackofficeApi? _backofficeApi;

  void configure(String apiUrl) {
    _apiUrl = apiUrl;
    _backofficeApi = null;
  }

  Future<bool> canReachBackendAsync(String token) async {
    try {
      var api = _getBackofficeApi(token);
      await api.getHealthApi().health();
      return true;
    } catch (e) {
      // cannot reach
      return false;
    }
  }

  Future<List<Category>> getCategoriesAsync(String token) async {
    try {
      var api = _getBackofficeApi(token);
      var listResponse = await api.getCategoryApi().listCategories();
      if (listResponse.data != null) {
        return listResponse.data!
            .map((x) => Category(
                  x.id!,
                  x.name!,
                  x.scanFunction ?? 0,
                ))
            .toList();
      }
    } catch (e) {
      //
    }
    return List<Category>.empty();
  }

  Future<List<Activity>> getActivitiesAsync(
      String token, int? categoryId) async {
    try {
      var api = _getBackofficeApi(token);
      Iterable<EventDTO>? list;
      var response = await api.getEventApi().listEvents(categoryId: categoryId);
      list = response.data;

      if (list != null) {
        return list.map(DtoHelper.fromEventDTO).toList();
      }
    } catch (e) {
      _logger.e('Exception in BackendDataStore->getActivitiesAsync', e);
    }
    return List<Activity>.empty();
  }

  Future<Activity?> getActivityAsync(String token, int activityId) async {
    try {
      var api = _getBackofficeApi(token);
      var eventApi = api.getEventApi();
      var eventResponse = await eventApi.getParticipants(eventId: activityId);
      if (eventResponse.data == null) {
        return null;
      }
      var eventDTO = eventResponse.data!;
      return DtoHelper.fromEventDTO(eventDTO);
    } catch (e) {
      _logger.e('Exception in BackendDataStore->getActivityAsync', e);
    }
    return null;
  }

  Future<Person?> getPerson(String token, String id) async {
    var api = _getBackofficeApi(token);

    var response = await api.getPersonApi().getPerson(personId: id);
    var personDTO = response.data;
    if (personDTO == null) {
      return null;
    }
    return DtoHelper.fromPersonDTO(personDTO);
  }

  Future<AccessCheckResult> queryAccessAsync(
      String token, int activityId, String personKey, DateTime scanTime) async {
    var api = _getBackofficeApi(token);
    var dto = ScanTimeDTOBuilder();
    dto.scanTime = scanTime.toLocal().toIso8601String();
    // strip 'Z'
    if (dto.scanTime!.endsWith('Z')) {
      dto.scanTime = dto.scanTime!.substring(0, dto.scanTime!.length - 1);
    }
    var scanTimeDTO = dto.build();
    _logger.d('Scan time sent to API ${scanTimeDTO.scanTime}');
    var accessResponse = await api.getEventApi().patchParticipant(
          eventId: activityId,
          personId: personKey,
          scanTimeDTO: scanTimeDTO,
        );
    var response = accessResponse.data;
    if (response == null) {
      return AccessCheckResult(
          scanResult: ScanResult.deny, message: 'No data returned');
    }
    switch (response.grant) {
      case 'pass':
        return AccessCheckResult(scanResult: ScanResult.pass);
      case 'check':
        _logger.d('Scan time returned from API ${response.prevScanTime}');
        return AccessCheckResult(
            scanResult: ScanResult.check,
            prevScanTime: DtoHelper.convertDate(response.prevScanTime, null));
      case 'deny':
        return AccessCheckResult(scanResult: ScanResult.deny);
      default:
        return AccessCheckResult(
            scanResult: ScanResult.error,
            message: 'Unknown access grant value returned: ${response.grant}');
    }
  }

  BackofficeApi _getBackofficeApi(var token) {
    _backofficeApi ??= BackofficeApi(basePathOverride: _apiUrl);
    // Set the (refreshed) token for authentication.
    // Note: the OAuthInterceptor expects the name/key 'OAuth2' because
    // it was generated as such with the OpenApi Generator.
    _backofficeApi!.setOAuthToken('OAuth2', token);
    return _backofficeApi!;
  }
}
