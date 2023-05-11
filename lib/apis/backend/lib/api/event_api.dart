//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class EventApi {
  EventApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /api/event/{eventId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] eventId (required):
  Future<Response> getEventWithHttpInfo(int eventId,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/event/{eventId}'
      .replaceAll('{eventId}', eventId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] eventId (required):
  Future<EventDTO?> getEvent(int eventId,) async {
    final response = await getEventWithHttpInfo(eventId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'EventDTO',) as EventDTO;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /api/event/{eventId}/participant' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] eventId (required):
  Future<Response> getParticipantsWithHttpInfo(int eventId,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/event/{eventId}/participant'
      .replaceAll('{eventId}', eventId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] eventId (required):
  Future<List<ParticipantDTO>?> getParticipants(int eventId,) async {
    final response = await getParticipantsWithHttpInfo(eventId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<ParticipantDTO>') as List)
        .cast<ParticipantDTO>()
        .toList();

    }
    return null;
  }

  /// Performs an HTTP 'GET /api/event' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] categoryId:
  Future<Response> listEventsWithHttpInfo({ int? categoryId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/event';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (categoryId != null) {
      queryParams.addAll(_queryParams('', 'categoryId', categoryId));
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] categoryId:
  Future<List<EventDTO>?> listEvents({ int? categoryId, }) async {
    final response = await listEventsWithHttpInfo( categoryId: categoryId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<EventDTO>') as List)
        .cast<EventDTO>()
        .toList();

    }
    return null;
  }

  /// Performs an HTTP 'PATCH /api/event/{eventId}/participant/{participantId}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] eventId (required):
  ///
  /// * [String] participantId (required):
  ///
  /// * [ScanTimeDTO] scanTimeDTO (required):
  Future<Response> patchParticipantWithHttpInfo(int eventId, String participantId, ScanTimeDTO scanTimeDTO,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/event/{eventId}/participant/{participantId}'
      .replaceAll('{eventId}', eventId.toString())
      .replaceAll('{participantId}', participantId);

    // ignore: prefer_final_locals
    Object? postBody = scanTimeDTO;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] eventId (required):
  ///
  /// * [String] participantId (required):
  ///
  /// * [ScanTimeDTO] scanTimeDTO (required):
  Future<ScanTimeResponseDTO?> patchParticipant(int eventId, String participantId, ScanTimeDTO scanTimeDTO,) async {
    final response = await patchParticipantWithHttpInfo(eventId, participantId, scanTimeDTO,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ScanTimeResponseDTO',) as ScanTimeResponseDTO;
    
    }
    return null;
  }
}
