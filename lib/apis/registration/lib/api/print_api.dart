//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class PrintApi {
  PrintApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'POST /Print' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [PrintRequestDTO] printRequestDTO:
  Future<Response> printPostWithHttpInfo({ PrintRequestDTO? printRequestDTO, }) async {
    // ignore: prefer_const_declarations
    final path = r'/Print';

    // ignore: prefer_final_locals
    Object? postBody = printRequestDTO;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json', 'text/json', 'application/*+json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [PrintRequestDTO] printRequestDTO:
  Future<void> printPost({ PrintRequestDTO? printRequestDTO, }) async {
    final response = await printPostWithHttpInfo( printRequestDTO: printRequestDTO, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
