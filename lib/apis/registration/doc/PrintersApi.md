# openapi.api.PrintersApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**printersGet**](PrintersApi.md#printersget) | **GET** /Printers | 


# **printersGet**
> BuiltList<String> printersGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPrintersApi();

try {
    final response = api.printersGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling PrintersApi->printersGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**BuiltList&lt;String&gt;**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

