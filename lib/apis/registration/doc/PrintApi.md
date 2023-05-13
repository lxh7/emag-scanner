# openapi.api.PrintApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**printPost**](PrintApi.md#printpost) | **POST** /Print | 


# **printPost**
> printPost(printRequestDTO)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = PrintApi();
final printRequestDTO = PrintRequestDTO(); // PrintRequestDTO | 

try {
    api_instance.printPost(printRequestDTO);
} catch (e) {
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

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

