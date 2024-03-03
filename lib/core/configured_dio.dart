import 'package:clean_arch_movie_app/core/presentation/app_config.dart';
import 'package:dio/dio.dart';

class ConfiguredDio {
  static final String _baseUrl = AppConfig().apiUrl;
  late final Dio dio;

  ConfiguredDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {
          'Authorization': 'Bearer Wookie2021',
        },
        connectTimeout: AppConfig().secondsTimeout * 1000,
        receiveTimeout: AppConfig().secondsTimeout * 1000,
      ),
    );
  }
}
