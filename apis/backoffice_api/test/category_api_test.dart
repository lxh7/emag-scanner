import 'package:test/test.dart';
import 'package:backoffice_api/backoffice_api.dart';


/// tests for CategoryApi
void main() {
  final instance = BackofficeApi().getCategoryApi();

  group(CategoryApi, () {
    //Future<BuiltList<CategoryDTO>> listCategories() async
    test('test listCategories', () async {
      // TODO
    });

  });
}
