import 'package:clean_arch_movie_app/core/dio_client.dart';
import 'package:clean_arch_movie_app/core/enums.dart';
import 'package:clean_arch_movie_app/features/movies/data/models/movie_model.dart';

class MoviesRemoteDataSource {
  final DioClient _dio;
  static const _path = '/movies';

  MoviesRemoteDataSource(this._dio);

  Future<List<MovieModel>> getAll() async {
    final result = await _dio.call(
      DioParams(HttpMethod.GET,
          endpoint: _path,
          headers: {
            'Authorization': 'Bearer Wookie2021',
          },
          shouldHandleResponse: false,
          needAuthrorize: false),
    );
    return MovieModel.fromJsonList(result);
  }

  Future<List<MovieModel>> search(String text) async {
    final result = await _dio.call(DioParams(HttpMethod.GET,
        endpoint: '/$_path?q=$text',
        headers: {
          'Authorization': 'Bearer Wookie2021',
        },
        shouldHandleResponse: false,
        needAuthrorize: false));
    return MovieModel.fromJsonList(result);
  }
}
