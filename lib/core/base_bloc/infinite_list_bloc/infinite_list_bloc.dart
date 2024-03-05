import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/infinite_list_bloc/infinite_list_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/infinite_list_bloc/infinite_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfiniteListBloc<T> extends Bloc<BaseEvent, InfiniteListState<T>> {
  InfiniteListBloc({
    required this.fetchListItems,
    InfiniteListState<T>? initialState,
    Filter? filter,
  }) : super(initialState ?? InfiniteListState<T>(filter: filter)) {
    on<OnFetchInfiniteList>((event, emit) async {
      final newFilter = event.filter ?? state.filter;
      final reset = event.refresh || event.filter != null;

      if (reset) {
        // update the filter to prevent any logical errors
        emit(
          state.copyWith(
            nextPage: 1,
            filter: newFilter,
            status: Status.loading,
          ),
        );
      }

      // update the state to loading
      if (state.status != Status.loading) {
        emit(state.copyWith(paginationStatus: Status.loading));
      }

      try {
        // fetch the list
        final fetchedList = await fetchListItems(page: state.nextPage, filter: newFilter);

        if (isClosed) return;

        // update the state as empty but don't make the existing list empty
        if (fetchedList.items.isEmpty) {
          emit(
            state.copyWith(
              status: Status.empty,
              paginationStatus: Status.empty,
              filter: fetchedList.filter ?? newFilter,
            ),
          );
          return;
        }

        // update the state with the list data
        emit(
          InfiniteListState<T>(
            status: Status.success,
            hasNext: fetchedList.hasNext,
            nextPage: fetchedList.nextPage ?? 1,
            filter: fetchedList.filter ?? newFilter,
            items: reset ? fetchedList.items : state.items + fetchedList.items,
          ),
        );
      } catch (error) {
        // update the state as error
        if (state.items.isEmpty || reset) {
          emit(state.copyWith(status: Status.failure, error: error));
        } else {
          emit(
            state.copyWith(paginationStatus: Status.failure, error: error),
          );
        }
      }
    }, transformer: droppable());
    add(OnFetchInfiniteList(filter: filter));
  }

  final Future<PagingEntity<T>> Function({
    required int page,
    Filter? filter,
  }) fetchListItems;
}

abstract class Filter {
  const Filter();
}

enum Status { loading, success, failure, empty }

class PagingEntity<T> {
  PagingEntity({
    required this.nextPage,
    required this.hasNext,
    List<T>? items,
    this.filter,
  }) : super() {
    this.items = items ?? const [];
  }

  PagingEntity.empty({
    this.filter,
    this.nextPage,
    this.hasNext = false,
    this.items = const [],
  });

  /// true if the list has items on the next page (should be provided in the API response)
  final bool hasNext;

  /// list of fetched items on the current page
  late List<T> items;

  /// page number to fetch in the next call (should be provided in the API response)
  final int? nextPage;

  /// filters used to fetch the list
  final Filter? filter;

  PagingEntity<T> operator +(PagingEntity<T> other) {
    return PagingEntity(
      hasNext: other.hasNext,
      nextPage: other.nextPage,
      items: items + other.items,
    );
  }

  PagingEntity<T> copyWith({
    Filter? filter,
    List<T>? items,
    bool? hasNext,
    int? nextPage,
  }) {
    return PagingEntity(
      items: items ?? this.items,
      filter: filter ?? this.filter,
      hasNext: hasNext ?? this.hasNext,
      nextPage: nextPage ?? this.nextPage,
    );
  }
}
