part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
}
class OnLoadMovies extends BaseEvent {
  @override
  List<Object> get props => [];
}
