# backoffice_api.api.CategoryApi

## Load the API package
```dart
import 'package:backoffice_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listCategories**](CategoryApi.md#listcategories) | **GET** /api/category | 


# **listCategories**
> BuiltList<CategoryDTO> listCategories()



### Example
```dart
import 'package:backoffice_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = BackofficeApi().getCategoryApi();

try {
    final response = api.listCategories();
    print(response);
} catch on DioError (e) {
    print('Exception when calling CategoryApi->listCategories: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;CategoryDTO&gt;**](CategoryDTO.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

