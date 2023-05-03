# openapi.api.EventApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getEvent**](EventApi.md#getevent) | **GET** /api/event/{eventId} | 
[**getParticipants**](EventApi.md#getparticipants) | **GET** /api/event/{eventId}/participant | 
[**listEvents**](EventApi.md#listevents) | **GET** /api/event | 
[**patchParticipant**](EventApi.md#patchparticipant) | **PATCH** /api/event/{eventId}/participant/{participantId} | 


# **getEvent**
> EventDTO getEvent(eventId)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = EventApi();
final eventId = 56; // int | 

try {
    final result = api_instance.getEvent(eventId);
    print(result);
} catch (e) {
    print('Exception when calling EventApi->getEvent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **eventId** | **int**|  | 

### Return type

[**EventDTO**](EventDTO.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getParticipants**
> List<ParticipantDTO> getParticipants(eventId)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = EventApi();
final eventId = 56; // int | 

try {
    final result = api_instance.getParticipants(eventId);
    print(result);
} catch (e) {
    print('Exception when calling EventApi->getParticipants: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **eventId** | **int**|  | 

### Return type

[**List<ParticipantDTO>**](ParticipantDTO.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listEvents**
> List<EventDTO> listEvents(categoryId)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = EventApi();
final categoryId = 56; // int | 

try {
    final result = api_instance.listEvents(categoryId);
    print(result);
} catch (e) {
    print('Exception when calling EventApi->listEvents: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryId** | **int**|  | [optional] 

### Return type

[**List<EventDTO>**](EventDTO.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **patchParticipant**
> ScanTimeResponseDTO patchParticipant(eventId, participantId, scanTimeDTO)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = EventApi();
final eventId = 56; // int | 
final participantId = participantId_example; // String | 
final scanTimeDTO = ScanTimeDTO(); // ScanTimeDTO | 

try {
    final result = api_instance.patchParticipant(eventId, participantId, scanTimeDTO);
    print(result);
} catch (e) {
    print('Exception when calling EventApi->patchParticipant: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **eventId** | **int**|  | 
 **participantId** | **String**|  | 
 **scanTimeDTO** | [**ScanTimeDTO**](ScanTimeDTO.md)|  | 

### Return type

[**ScanTimeResponseDTO**](ScanTimeResponseDTO.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

