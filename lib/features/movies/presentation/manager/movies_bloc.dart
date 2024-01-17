import 'package:clean_arch_movie_app/core/base_bloc/base_bloc.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:clean_arch_movie_app/core/use_case/use_case.dart';
import 'package:clean_arch_movie_app/features/movies/domain/entities/genre_movies.dart';
import 'package:clean_arch_movie_app/features/movies/domain/use_cases/get_movies_use_case.dart';
import 'package:equatable/equatable.dart';
part 'movies_event.dart';

class MoviesBloc extends BaseBloc {
  final GetMoviesUseCase getMoviesUseCase;

  MoviesBloc(this.getMoviesUseCase) : super(InitialState()) {
    onLoad<OnLoadMovies>((event, emit) async {
      final result = await getMoviesUseCase.call(NoParams());
      emit(result.fold(
        (failure) => ErrorState(),
        (movies) => DataLoadedState<List<GenreMovies>>(movies),
      ));
    });
  }
}
