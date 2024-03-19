import 'dart:async';

import 'package:clean_arch_movie_app/core/base_bloc/infinite_list_bloc/infinite_list_bloc.dart';
import 'package:clean_arch_movie_app/core/base_bloc/infinite_list_bloc/infinite_list_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/infinite_list_bloc/infinite_list_state.dart';
import 'package:clean_arch_movie_app/core/presentation/widgets/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:rive_pull_to_refresh/rive_pull_to_refresh.dart';

/// [loadingWidget] to show when the next subsequent page is being fetched
class InfiniteListTheme {
  InfiniteListTheme({
    this.paginationLoadingWidget,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
  });

  final Widget? errorWidget;
  final Widget? emptyWidget;
  final Widget? loadingWidget;

  final Widget? paginationLoadingWidget;
}

// ignore: must_be_immutable
class InfiniteListView<T> extends StatelessWidget {
  ///[controller]If you use scrollcontroller param you have to dispose it yourself.<br />
  ///[getItems] make the use_case return PagingEntity<T> <br />
  ///ex: Future<Either<Failure, PagingEntity<ItemEntity>>> call(Param params) {
  ///  return repo.getIntems(params);
  ///}
  InfiniteListView({
    super.key,
    required this.itemBuilder,
    required Future<PagingEntity<T>> Function({required int page, Filter? filter}) getItems,
    this.controller,
    Filter? filter,
    InfiniteListTheme? infiniteListTheme,
  }) : super() {
    infiniteListBloc = InfiniteListBloc<T>(getItems: getItems, filter: filter);

    _infiniteListTheme = infiniteListTheme ??
        //Default
        InfiniteListTheme(
            loadingWidget: const LoadingWidget(),
            errorWidget: Center(child: Text('an_error_has_occured'.tr())),
            emptyWidget: const SizedBox.shrink(),
            paginationLoadingWidget: const LoadingWidget());
  }

  late ScrollController? controller;
  late InfiniteListTheme _infiniteListTheme;

  /// [itemBuilder] widget for the individual list item
  final ItemWidgetBuilder<T> itemBuilder;
  late InfiniteListBloc<T> infiniteListBloc;
  Widget builder(BuildContext context, InfiniteListState state) {
    late final Widget widget;
    // set all the default widgets for each state
    switch (state.status) {
      case Status.loading:
        widget = _infiniteListTheme.loadingWidget!;
        break;
      case Status.success:
        widget = _PaginatedListView<T>(
            controller: controller,
            itemBuilder: itemBuilder,
            infiniteListTheme: _infiniteListTheme,
            infiniteListBloc: infiniteListBloc);
        break;
      case Status.empty:
        widget = _infiniteListTheme.emptyWidget!;
        break;
      case Status.failure:
        widget = _infiniteListTheme.errorWidget!;
        break;
    }

    return widget;
  }

  SMIBool? _bump;
  RivePullToRefreshController? _rivePullToRefreshController;

  SMINumber? _smiNumber;
  @override
  Widget build(BuildContext context) {
    return RivePullToRefresh(
      onInit: (controller) {
        _rivePullToRefreshController = controller;
      },
      style: RivePullToRefreshStyle.header,
      bump: () async {
        //action start anim when stop Scrool
        _bump?.value = true;

        //time play anim

        await _rivePullToRefreshController!.onRefresh!();

        //close header
        await _rivePullToRefreshController!.close();

        //reset rive, design from rive.riv
        _bump?.value = false;

        //call function onRefresh

        //TimeStartAnim
      },
      callBacknumber: (number) {
        _smiNumber?.value = number;
      },
      riveWidget: RiveAnimation.asset(
        'assets/rives/pullrf.riv',
        onInit: _onRiveInit,
      ),
      controller: controller,
      onRefresh: () async {
        Completer completer = Completer();

        infiniteListBloc.add(OnLoadInfiniteList(
            refresh: true,
            onDone: () {
              completer.complete();
            }));
        return await completer.future;
      },
      height: 100,
      child: BlocBuilder<InfiniteListBloc, InfiniteListState>(bloc: infiniteListBloc, builder: builder),
    );
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, "State Machine");
    artboard.addController(controller!);

    _bump = controller.findInput<bool>("Active") as SMIBool;

    _smiNumber = controller.findInput<double>("NumStart") as SMINumber;
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
    this.controller,
    required this.infiniteListBloc,
    required this.infiniteListTheme,
  });

  final ScrollController? controller;
  final InfiniteListTheme infiniteListTheme;
  final ItemWidgetBuilder<T> itemBuilder;
  final InfiniteListBloc<T> infiniteListBloc;

  @override
  State<_PaginatedListView<T>> createState() => __PaginatedListViewState<T>();
}

class __PaginatedListViewState<T> extends State<_PaginatedListView<T>> {
  late final InfiniteListBloc<T> fetchListBloc;
  late ScrollController _controller;
  late InfiniteListTheme _infiniteListTheme;

  void _onScroll() {
    if (_controller.hasClients == true &&
        _controller.position.maxScrollExtent == _controller.offset &&
        fetchListBloc.state.hasNext &&
        fetchListBloc.state.paginationStatus != Status.loading &&
        // if an error occurs in pagination then stop further pagination calls
        fetchListBloc.state.error == null) {
      fetchListBloc.add(OnLoadInfiniteList());
    }
  }

  @override
  void initState() {
    super.initState();
    _infiniteListTheme = widget.infiniteListTheme;
    fetchListBloc = widget.infiniteListBloc;
    _controller = widget.controller ?? ScrollController();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller
        ..removeListener(_onScroll)
        ..dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InfiniteListBloc<T>, InfiniteListState<T>, int>(
      bloc: fetchListBloc,
      selector: (state) => state.items.length,
      builder: (context, length) {
        return ListView.builder(
          padding: EdgeInsets.zero,
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
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: paginationStatus.name == Status.loading.name ? 1 : 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _infiniteListTheme.loadingWidget!,
                        ),
                      ),
                      Opacity(
                        opacity: paginationStatus.name == Status.failure.name ? 1 : 0,
                        child: _infiniteListTheme.errorWidget,
                      ),
                    ],
                  );
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
        );
      },
    );
  }
}
