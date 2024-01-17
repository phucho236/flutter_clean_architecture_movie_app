import 'package:clean_arch_movie_app/core/failures/failures.dart';
import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {}

class BaseStateWithoutProps extends BaseState {
  @override
  List<Object?> get props => [];
}

class InitialState extends BaseStateWithoutProps {}

class LoadingState extends BaseStateWithoutProps {}

class ErrorState extends BaseState {
  final Failure? failure;
  ErrorState({this.failure});

  @override
  List<Object?> get props => [failure];
}

class DataLoadedState<T> extends BaseState {
  final T data;

  DataLoadedState(this.data);

  @override
  List<Object?> get props => [data];
}
