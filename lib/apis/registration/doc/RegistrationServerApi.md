# openapi.api.RegistrationServerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**rootGet**](RegistrationServerApi.md#rootget) | **GET** / | 


# **rootGet**
> String rootGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRegistrationServerApi();

try {
    final response = api.rootGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling RegistrationServerApi->rootGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

