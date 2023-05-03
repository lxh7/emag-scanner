# openapi.api.ParticipantApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listParticipants**](ParticipantApi.md#listparticipants) | **GET** /api/participant | 


# **listParticipants**
> List<ParticipantDTO> listParticipants(eventId)



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ParticipantApi();
final eventId = 56; // int | 

try {
    final result = api_instance.listParticipants(eventId);
    print(result);
} catch (e) {
    print('Exception when calling ParticipantApi->listParticipants: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **eventId** | **int**|  | [optional] 

### Return type

[**List<ParticipantDTO>**](ParticipantDTO.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

