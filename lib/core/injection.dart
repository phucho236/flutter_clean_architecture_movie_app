import 'package:clean_arch_movie_app/core/dio_client.dart';
import 'package:clean_arch_movie_app/core/network/network_info.dart';
import 'package:clean_arch_movie_app/core/presentation/app_config.dart';
import 'package:clean_arch_movie_app/core/presentation/storage.dart';
import 'package:clean_arch_movie_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:clean_arch_movie_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:clean_arch_movie_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:clean_arch_movie_app/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:clean_arch_movie_app/features/movies/data/data_sources/movies_remote_data_source.dart';
import 'package:clean_arch_movie_app/features/movies/data/movies_genres_generator.dart';
import 'package:clean_arch_movie_app/features/movies/data/repositories/movies_repo_impl.dart';
import 'package:clean_arch_movie_app/features/movies/domain/use_cases/get_movies_use_case.dart';
import 'package:clean_arch_movie_app/features/movies/domain/use_cases/search_movies_use_case.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/manager/movies_bloc.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/manager/movies_search_bloc/movies_search_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class Injection {
  static setup() async {
    final dioClient = DioClient(
      dio: Dio(),
      appConfig: AppConfig(),
    );
    final networkInfo = NetworkInfo();
    getIt.registerSingleton<MoviesRepoImpl>(
      MoviesRepoImpl(MoviesRemoteDataSource(dioClient), GenreMoviesGenerator()),
    );
    getIt.registerFactory<MoviesBloc>(() => MoviesBloc(
          GetMoviesUseCase(getIt.get<MoviesRepoImpl>()),
        ));
    getIt.registerFactory<MoviesSearchBloc>(() => MoviesSearchBloc(
          SearchMoviesUseCase(getIt.get<MoviesRepoImpl>()),
        ));
    getIt.registerSingleton<AuthRepoImpl>(
      AuthRepoImpl(networkInfo, AuthRemoteDataSourceImpl(dioClient)),
    );
    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(LoginUseCase(getIt.get<AuthRepoImpl>())),
    );
  }
}
