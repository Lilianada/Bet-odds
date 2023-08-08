import 'package:dio/dio.dart';

import '../../container_injector.dart';
import '../utils/app_constants.dart';
import 'interceptors.dart';

const String _contentType = "Content-Type";
const String _applicationJson = "application/json";
const String _apiKey = "ac2de663a4msh31a3aaa3a5e8808p122883jsnb520db3c2e87"; // Add your api key here
const int _timeOut = 20000;
const String _host = 'api-football-v1.p.rapidapi.com';

class DioHelper {
  final Dio dio;

  DioHelper({required this.dio}) {
    Map<String, dynamic> headers = {
      _contentType: _applicationJson,
      'x-rapidapi-host': _host,
      'x-rapidapi-key': _apiKey,
    };
    dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: _timeOut,
      connectTimeout: _timeOut,
      headers: headers,
    );
    dio.interceptors.add(sl<LogInterceptor>());
    dio.interceptors.add(sl<AppInterceptors>());
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    return await dio.get(url, queryParameters: queryParams);
  }
}
