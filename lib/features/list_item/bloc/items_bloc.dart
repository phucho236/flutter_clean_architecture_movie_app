import 'package:clean_arch_movie_app/core/base_bloc/base_bloc.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:clean_arch_movie_app/features/list_item/bloc/item_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

class ItemsBloc extends BaseBloc {
  int page = 1;
  int pageMax = 3;
  int pageSize = 10;
  bool isLoading = false;
  SortType sortType = SortType.asc;
  final PagingModel<ItemModel> pagingModel = PagingModel();
  ItemsBloc() : super(InitialState()) {
    on<SortItems>(_sortItems);

    on<LoadMoreItems>(_loadItems, transformer: droppable());
  }
  Comparator<ItemModel> sortASCById = (a, b) => a.id!.compareTo(b.id!);
  Comparator<ItemModel> sortDescById = (a, b) => b.id!.compareTo(a.id!);

  void _sortItems(SortItems event, Emitter<BaseState> emit) {
    if (event.sortType != null) {
      sortType = event.sortType!;
    } else {
      if (sortType.name == SortType.asc.name) {
        sortType = SortType.desc;
      } else {
        sortType = SortType.asc;
      }
    }
    if (sortType == SortType.asc) {
      pagingModel.items.sort(sortASCById);
    } else {
      pagingModel.items.sort(sortDescById);
    }
    // pagingModel.items = List.of(pagingModel.items);
    emit(DataLoadedState<PagingModel>(pagingModel));
  }

  void _loadItems(LoadMoreItems event, Emitter<BaseState> emit) async {
    isLoading = true;
    if (event.isRefesh) {
      page = 1;
      pagingModel.items.clear();
      emit(LoadingState());
    }
    if (page == pageMax + 1) {
      return;
    }

    if (!event.isRefesh && page > 1) {
      emit(DataLoadedState<PagingModel>(pagingModel.copyWith(isLoadMore: true)));
    }
    await Future.delayed(const Duration(seconds: 2));
    var currentLengh = pageSize * (page - 1);
    pagingModel.items.addAll(List.generate(
      10,
      (index) {
        var indexTmp = currentLengh + index + 1;
        return ItemModel(id: indexTmp, name: "Name $indexTmp");
      },
    ));

    page = page + 1;
    emit(DataLoadedState<PagingModel>(pagingModel.copyWith(isLoadMore: page == pageMax)));
  }
}

class PagingModel<T> {
  PagingModel({List<T>? items, this.isLoadMore = false}) : super() {
    this.items = items ?? [];
  }
  late List<T> items;
  bool isLoadMore;
  copyWith({List<T>? items, bool? isLoadMore}) {
    return PagingModel(items: items ?? this.items, isLoadMore: isLoadMore ?? this.isLoadMore);
  }
}
