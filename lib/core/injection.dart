import 'package:clean_arch_movie_app/core/configured_dio.dart';
import 'package:clean_arch_movie_app/core/constants/constants.dart';
import 'package:clean_arch_movie_app/core/network/network_info.dart';
import 'package:clean_arch_movie_app/core/presentation/app_message.dart';
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
    final dio = getIt.registerSingleton<Dio>(ConfiguredDio().dio);
    final networkInfo = getIt.registerSingleton<NetworkInfo>(NetworkInfo());
    getIt.registerSingleton<MoviesRepoImpl>(
      MoviesRepoImpl(MoviesRemoteDataSource(dio), GenreMoviesGenerator()),
    );
    getIt.registerFactory<MoviesBloc>(() => MoviesBloc(
          GetMoviesUseCase(getIt.get<MoviesRepoImpl>()),
        ));
    getIt.registerFactory<MoviesSearchBloc>(() => MoviesSearchBloc(
          SearchMoviesUseCase(getIt.get<MoviesRepoImpl>()),
        ));
    getIt.registerSingleton<AuthRepoImpl>(
      AuthRepoImpl(networkInfo, AuthRemoteDataSourceImpl(dio)),
    );
    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(LoginUseCase(getIt.get<AuthRepoImpl>())),
    );
  }
}
