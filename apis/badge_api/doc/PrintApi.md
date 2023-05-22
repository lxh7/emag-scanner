# badge_api.api.PrintApi

## Load the API package
```dart
import 'package:badge_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**printPost**](PrintApi.md#printpost) | **POST** /Print | 


# **printPost**
> printPost(printRequestDTO)



### Example
```dart
import 'package:badge_api/api.dart';
// TODO Configure HTTP basic authorization: Bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('Bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('Bearer').password = 'YOUR_PASSWORD';

final api = BadgeApi().getPrintApi();
final PrintRequestDTO printRequestDTO = ; // PrintRequestDTO | 

try {
    api.printPost(printRequestDTO);
} catch on DioError (e) {
    print('Exception when calling PrintApi->printPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **printRequestDTO** | [**PrintRequestDTO**](PrintRequestDTO.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

