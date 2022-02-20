import 'package:chuck_norris/api/dio_client.dart';

class CategoriesRepository {
  var _dioClient = DioClient();
  Future<List<String>?> getCategories() => _dioClient.getCategories();
}
