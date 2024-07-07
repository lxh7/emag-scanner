# backoffice_api.api.DefaultApi

## Load the API package
```dart
import 'package:backoffice_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiDocJsonGet**](DefaultApi.md#apidocjsonget) | **GET** /api/doc.json | 


# **apiDocJsonGet**
> apiDocJsonGet()



### Example
```dart
import 'package:backoffice_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = BackofficeApi().getDefaultApi();

try {
    api.apiDocJsonGet();
} catch on DioError (e) {
    print('Exception when calling DefaultApi->apiDocJsonGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2), [OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

