import 'package:chuck_norris/models/joke_model.dart';
import 'package:chuck_norris/models/search_model.dart';
import 'package:dio/dio.dart';

class DioClient {
  static String url = 'https://api.chucknorris.io/jokes/';

  Future<JokeModel?> getRandomJoke([String category = '']) async {
    var dio = Dio();
    Response response = await dio
        .get('${url}random${category != '' ? '?category=$category' : ''}');
    if (response.statusCode == 200) {
      return JokeModel.fromJson(response.data);
    }
    return null;
  }

  Future<List<String>?> getCategories() async {
    var dio = Dio();
    Response response = await dio.get(url + 'categories');
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>).map((e) => e as String).toList();
    }
    return null;
  }

  Future<SearchModel?> search(String query) async {
    var dio = Dio();
    try {
      Response response = await dio.get('${url}search?query=$query');
      if (response.statusCode == 200) {
        return SearchModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioError catch (_) {
      return null;
    }
  }
}
