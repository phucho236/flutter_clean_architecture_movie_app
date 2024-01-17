import 'package:bloc/bloc.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_bloc.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:clean_arch_movie_app/features/movies/domain/entities/movie.dart';
import 'package:clean_arch_movie_app/features/movies/domain/use_cases/search_movies_use_case.dart';
import 'package:rxdart/rxdart.dart';

const _duration = Duration(milliseconds: 700);

EventTransformer<Event> debounceTransformer<Event>(Duration duration) {
  return (events, mapper) {
    return events.debounceTime(duration).switchMap(mapper);
  };
}

class MoviesSearchBloc extends BaseBloc {
  final SearchMoviesUseCase searchMoviesUseCase;

  MoviesSearchBloc(this.searchMoviesUseCase) : super(InitialState()) {
    onLoad<OnChange<String>>(_onTextChanged, transformer: debounceTransformer(_duration));
  }

  void _onTextChanged(
    OnChange event,
    Emitter<BaseState> emit,
  ) async {
    final results = await searchMoviesUseCase.call(SearchParams(event.value));
    emit(results.fold((l) => ErrorState(), (r) => DataLoadedState<List<Movie>>(r)));
  }
}
