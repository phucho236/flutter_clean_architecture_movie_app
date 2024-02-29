import 'package:clean_arch_movie_app/core/presentation/app_config.dart';
import 'package:dio/dio.dart';

class ConfiguredDio {
  static  final String _host = AppConfig().apiUrl;
  late final Dio dio;

  ConfiguredDio() {
    dio = Dio(BaseOptions(baseUrl: _host, headers: {
      'Authorization': 'Bearer Wookie2021',
    }));
  }
}
