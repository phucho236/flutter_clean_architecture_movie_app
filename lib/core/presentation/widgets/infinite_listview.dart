import 'package:clean_arch_movie_app/core/base_bloc/infinite_list_bloc/infinite_list_bloc.dart';
import 'package:clean_arch_movie_app/core/base_bloc/infinite_list_bloc/infinite_list_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/infinite_list_bloc/infinite_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class InfiniteListView<T> extends StatelessWidget {
  InfiniteListView(
      {super.key,
      required this.itemBuilder,
      required Future<PagingEntity<T>> Function({
        required int page,
        Filter? filter,
      })
          fetchListItems,
      //Wrap here to Infinity Loading Theme
      this.paginationLoadingWidget,
      this.loadingWidget,
      this.errorWidget,
      this.emptyWidget,
      this.controller,
      Filter? filter
      //
      })
      : super() {
    infiniteListBloc = InfiniteListBloc<T>(fetchListItems: fetchListItems, filter: filter);
    controller;
  }

  final Widget? errorWidget;
  final Widget? emptyWidget;
  final Widget? loadingWidget;

  /// controller for the listview
  late ScrollController? controller;

  /// loading widget to show when the next subsequent page is being fetched
  final Widget? paginationLoadingWidget;

  /// builder widget for the individual list item
  final ItemWidgetBuilder<T> itemBuilder;
  late InfiniteListBloc<T> infiniteListBloc;
  Widget builder(BuildContext context, InfiniteListState state) {
    late final Widget widget;
    // set all the default widgets for each state
    switch (state.status) {
      case Status.loading:
        widget = loadingWidget ??
            const Center(
              child: CircularProgressIndicator(),
            );
        break;
      case Status.success:
        widget = _PaginatedListView<T>(
            controller: controller,
            itemBuilder: itemBuilder,
            paginationLoadingWidget: paginationLoadingWidget,
            infiniteListBloc: infiniteListBloc);
        break;
      case Status.empty:
        widget = emptyWidget ??
            const Center(
              child: CircularProgressIndicator(),
            );
        break;
      case Status.failure:
        widget = errorWidget ?? const SizedBox();
        break;
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfiniteListBloc, InfiniteListState>(bloc: infiniteListBloc, builder: builder);
  }
}

typedef ItemWidgetBuilder<T> = Widget Function(
  BuildContext context,
  int index,
  T item,
);

class _PaginatedListView<T> extends StatefulWidget {
  const _PaginatedListView({
    super.key,
    required this.itemBuilder,
    this.paginationLoadingWidget,
    this.controller,
    required this.infiniteListBloc,
  });

  final ScrollController? controller;
  final Widget? paginationLoadingWidget;
  final ItemWidgetBuilder<T> itemBuilder;
  final InfiniteListBloc<T> infiniteListBloc;

  @override
  State<_PaginatedListView<T>> createState() => __PaginatedListViewState<T>();
}

class __PaginatedListViewState<T> extends State<_PaginatedListView<T>> {
  late final InfiniteListBloc<T> fetchListBloc;
  ScrollController? _controller;

  void _onScroll() {
    if (_controller?.hasClients == true &&
        _controller?.position.maxScrollExtent == _controller?.offset &&
        fetchListBloc.state.hasNext &&
        fetchListBloc.state.paginationStatus != Status.loading &&
        // if an error occurs in pagination then stop further pagination calls
        fetchListBloc.state.error == null) {
      fetchListBloc.add(OnFetchInfiniteList());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchListBloc = widget.infiniteListBloc;
    _controller = widget.controller ?? ScrollController();
    _controller?.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller!
        ..removeListener(_onScroll)
        ..dispose();
    }

    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InfiniteListBloc<T>, InfiniteListState<T>, int>(
      bloc: fetchListBloc,
      selector: (state) => state.items.length,
      builder: (context, length) {
        return RefreshIndicator(
          onRefresh: () async => fetchListBloc.add(OnFetchInfiniteList(refresh: true)),
          child: ListView.builder(
            itemCount: length + 1,
            controller: _controller,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // show the pagination status indicators on the last index
              if (index == length) {
                return BlocSelector<InfiniteListBloc<T>, InfiniteListState<T>, Status>(
                  bloc: fetchListBloc,
                  selector: (state) => state.paginationStatus,
                  builder: (context, paginationStatus) {
                    return Opacity(
                      opacity: paginationStatus.name == Status.loading.name ? 1 : 0,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );

                    // switch (paginationStatus) {
                    //   case Status.loading:
                    //     return Center(child: const CircularProgressIndicator());
                    // case Status.failure:
                    //   return const SizedBox();
                    // default:
                    //   return const SizedBox.shrink();
                    //}
                  },
                );
              }
              // show the item widget
              return widget.itemBuilder(
                context,
                index,
                fetchListBloc.state.items[index],
              );
            },
          ),
        );
      },
    );
  }
}
