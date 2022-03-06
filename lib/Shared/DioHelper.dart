//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=c27d6f860573426b8a78fdfdf716a52d
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://newsapi.org/",
    ));
  }

  static Future<Response> getData({
    required String path,
    required Map<String, dynamic> query,
  }) async {
    return await dio!.get(path, queryParameters: query);
  }
}
