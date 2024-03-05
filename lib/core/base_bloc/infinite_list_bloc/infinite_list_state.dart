import 'package:clean_arch_movie_app/core/base_bloc/infinite_list_bloc/infinite_list_bloc.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class InfiniteListState<T> extends Equatable {
  InfiniteListState({
    List<T>? items,
    this.error,
    this.filter,
    this.nextPage = 1,
    this.hasNext = false,
    this.status = Status.loading,
    this.paginationStatus = Status.empty,
  }) : super() {
    this.items = items ?? <T>[];
  }

  /// true if the list has items on the next page (should be provided in the API response)
  final bool hasNext;

  /// page number to fetch in the next call (should be provided in the API response)
  final int nextPage;

  /// list of fetched items
  late List<T> items;

  /// API call status of the first page
  final Status status;

  /// holds the error for the latest API call if any
  final Object? error;

  /// filters used to fetch the list
  final Filter? filter;

  /// API call status of the latest subsequent page
  final Status paginationStatus;

  String get errorMessage {
    if (error is Exception) return error.toString();

    return "Something went wrong";
  }

  InfiniteListState<T> copyWith({
    int? nextPage,
    bool? hasNext,
    Object? error,
    Status? status,
    List<T>? items,
    Filter? filter,
    Status? paginationStatus,
  }) {
    return InfiniteListState<T>(
      items: items ?? this.items,
      error: error ?? this.error,
      filter: filter ?? this.filter,
      status: status ?? this.status,
      hasNext: hasNext ?? this.hasNext,
      nextPage: nextPage ?? this.nextPage,
      paginationStatus: paginationStatus ?? this.paginationStatus,
    );
  }

  @override
  List<Object?> get props => [
        items,
        error,
        filter,
        status,
        hasNext,
        nextPage,
        paginationStatus,
      ];
}
