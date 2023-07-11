# backoffice_api.api.PersonApi

## Load the API package
```dart
import 'package:backoffice_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getPerson**](PersonApi.md#getperson) | **GET** /api/person/{personId} | 


# **getPerson**
> PersonDTO getPerson(personId)



### Example
```dart
import 'package:backoffice_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = BackofficeApi().getPersonApi();
final String personId = personId_example; // String | 

try {
    final response = api.getPerson(personId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling PersonApi->getPerson: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **personId** | **String**|  | 

### Return type

[**PersonDTO**](PersonDTO.md)

### Authorization

[OAuth2](../README.md#OAuth2), [OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

