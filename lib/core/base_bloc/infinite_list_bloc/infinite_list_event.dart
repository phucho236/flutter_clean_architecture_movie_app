import 'package:clean_arch_movie_app/core/base_bloc/base_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/infinite_list_bloc/infinite_list_bloc.dart';

class OnLoadInfiniteList extends BaseEvent {
  OnLoadInfiniteList({this.refresh = false, this.filter, this.onDone});
  final Function? onDone;

  /// whether to fetch the first page of the list (i.e. fetch the list from the start)
  final bool refresh;

  /// the filters needed to fetch the list
  final Filter? filter;

  @override
  List<Object?> get props => [refresh, filter, onDone];
}
