// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:equatable/equatable.dart';

abstract class BaseEvent extends Equatable {}

class OnInitial extends BaseState {
  @override
  List<Object?> get props => [];
}

class OnChange<T> extends BaseEvent {
  final T value;

  OnChange(this.value);

  @override
  List<Object?> get props => [value];
}
