import 'dart:async';
import 'package:clean_arch_movie_app/core/base_bloc/base_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef EventHandlerType<T> = FutureOr<void> Function(
  T event,
  Emitter<BaseState> emit,
);

typedef TransformerType<T> = Stream<T> Function(Stream<T>, Stream<T> Function(T))?;

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc(super.initialState) {
    on<BaseEvent>(onEveryEvent);
  }

  @override
  @mustCallSuper
  Future<void> close() {
    return super.close();
  }

  void onLoad<T extends BaseEvent>(EventHandlerType<T> handler,
      {TransformerType<T> transformer, LoadingState Function(T event)? loadingStateBuilder}) {
    on<T>(
      (event, emit) async {
        emit(loadingStateBuilder != null ? loadingStateBuilder(event) : LoadingState());
        await handler(event, emit);
      },
      transformer: transformer,
    );
  }

  FutureOr<void> onEveryEvent(BaseEvent event, Emitter<BaseState> emit) async {
    if (event is OnInitial) {
      emit(InitialState());
      return;
    }
  }
}
