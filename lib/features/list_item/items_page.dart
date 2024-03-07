import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:clean_arch_movie_app/core/base_bloc/infinite_list_bloc/infinite_list_bloc.dart';
import 'package:clean_arch_movie_app/core/presentation/widgets/app_button.dart';
import 'package:clean_arch_movie_app/core/presentation/widgets/infinite_listview.dart';
import 'package:clean_arch_movie_app/features/list_item/bloc/item_event.dart';
import 'package:clean_arch_movie_app/features/list_item/bloc/items_bloc.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatefulWidget {
  static String route = "/ItemsPages";
  const ItemsPage({Key? key}) : super(key: key);

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final bloc = ItemsBloc();
  final _scrollController = ScrollController();
  bool get _isBottom {
    if (_scrollController.position.extentAfter < 500) {
      return true;
    }
    return false;
  }

  void _onScroll() {
    if (_isBottom) bloc.add(LoadMoreItems());
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    bloc.add(LoadMoreItems());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // AppButton(
          //   content: "ASC",
          //   onTap: () {
          //     bloc.add(SortItems(sortType: SortType.asc));
          //   },
          // ),
          // AppButton(
          //   content: "DESC ",
          //   onTap: () {
          //     bloc.add(SortItems(sortType: SortType.desc));
          //   },
          // ),
          // AppButton(
          //   content: "Swap",
          //   onTap: () {
          //     bloc.add(SortItems());
          //   },
          // ),
          Expanded(
            child: InfiniteListView<String>(
              controller: ScrollController(),
              getItems: fetchListItems,
              itemBuilder: (context, index, item) {
                return Container(color: Colors.red, height: 200, child: Text(item + "123123"));
              },
            ),
          ),
          // Expanded(
          //   child: RefreshIndicator(
          //     onRefresh: () async {
          //       bloc.add(LoadMoreItems(isRefesh: true));
          //     },
          //     child: BlocBuilder<ItemsBloc, BaseState>(
          //       bloc: bloc,
          //       builder: (context, state) {
          //         if (state is DataLoadedState<PagingModel>) {
          //           var items = state.data.items;
          //           return ListView.builder(
          //             controller: _scrollController,
          //             itemCount: items.length + 1,
          //             itemBuilder: (context, index) {
          //               if (index == items.length) {
          //                 return Opacity(
          //                   opacity: state.data.isLoadMore ? 1 : 0,
          //                   child: const Padding(
          //                     padding: EdgeInsets.all(8.0),
          //                     child: Center(child: CircularProgressIndicator()),
          //                   ),
          //                 );
          //               }
          //               ItemModel item = items[index];
          //               return Padding(
          //                 padding: const EdgeInsets.symmetric(horizontal: 15),
          //                 child: SizedBox(
          //                   child: Column(
          //                     children: [
          //                       SizedBox(
          //                         height: 100,
          //                         child: Row(
          //                           children: [
          //                             Expanded(
          //                                 flex: 3,
          //                                 child: Padding(
          //                                   padding: const EdgeInsets.all(8.0),
          //                                   child: Container(
          //                                       decoration: BoxDecoration(
          //                                         borderRadius: BorderRadius.circular(15),
          //                                         color: Colors.amber.shade50,
          //                                       ),
          //                                       child: Center(child: Text('${item.id}'))),
          //                                 )),
          //                             Expanded(flex: 7, child: Text('${item.name}'))
          //                           ],
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               );
          //             },
          //           );
          //         }
          //         if (state is LoadingState) {
          //           return const Center(child: CircularProgressIndicator());
          //         }
          //         return const Center(child: CircularProgressIndicator());
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  var page123 = 1;
  Future<PagingEntity<String>> fetchListItems({Filter? filter, required int page}) async {
    await Future.delayed(const Duration(seconds: 1));
    var data = List.generate(10, (index) => DateTime.now().millisecondsSinceEpoch.toString()).toList();

    var value = PagingEntity(
      hasNext: page123 < 5,
      nextPage: page + 1,
      items: data,
    );
    page123 = page + 1;
    print('$page $page123');
    return value;
  }
}

class UserFilter extends Filter {
  const UserFilter({this.premiumUsers = false});

  final bool premiumUsers;
}
