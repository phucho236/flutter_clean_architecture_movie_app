import 'package:clean_arch_movie_app/core/dio_client.dart';
import 'package:clean_arch_movie_app/core/enums.dart';
import 'package:clean_arch_movie_app/features/movies/data/models/movie_model.dart';

class MoviesRemoteDataSource {
  final DioClient _dio;
  static const _path = '/movies';

  MoviesRemoteDataSource(this._dio);

  Future<List<MovieModel>> getAll() async {
    final result = await _dio.call(DioParams(HttpMethod.GET, endpoint: _path));
    return MovieModel.fromJsonList(result.data);
  }

  Future<List<MovieModel>> search(String text) async {
    final result = await _dio.call(DioParams(HttpMethod.GET, endpoint: '/$_path?q=$text'));
    return MovieModel.fromJsonList(result.data);
  }
}
