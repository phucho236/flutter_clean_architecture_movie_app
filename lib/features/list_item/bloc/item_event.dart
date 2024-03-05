import 'package:clean_arch_movie_app/core/base_bloc/base_event.dart';

class LoadMoreItems extends BaseEvent {
  LoadMoreItems({this.isRefesh = false});
  final bool isRefesh;
  @override
  List<Object?> get props => [isRefesh];
}

class SortItems extends BaseEvent {
  SortItems({this.sortType});

  final SortType? sortType;
  @override
  List<Object?> get props => [sortType];
}

enum SortType { asc, desc }

class ItemModel {
  ItemModel({this.id, this.name});
  final int? id;
  final String? name;
}
