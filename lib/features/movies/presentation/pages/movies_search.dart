import 'package:clean_arch_movie_app/core/base_bloc/base_event.dart';
import 'package:clean_arch_movie_app/core/base_bloc/base_state.dart';
import 'package:clean_arch_movie_app/core/injection.dart';
import 'package:clean_arch_movie_app/core/presentation/widgets/retry.dart';
import 'package:clean_arch_movie_app/features/movies/domain/entities/movie.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/manager/movies_search_bloc/movies_search_bloc.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/widgets/movie_search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesSearchRoot extends StatelessWidget {
  static const String route = '/MoviesSearchRoot';

  const MoviesSearchRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: MoviesSearch(), create: (context) => getIt.get<MoviesSearchBloc>()..add(OnChange<String>('')));
  }
}

// ignore: must_be_immutable
class MoviesSearch extends StatelessWidget {
  MoviesSearch({Key? key}) : super(key: key);
  String? _lastInputValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  onChanged: (inputValue) {
                    if (_lastInputValue != inputValue) {
                      _lastInputValue = inputValue;
                      context.read<MoviesSearchBloc>().add(OnChange<String>(inputValue));
                    }
                  },
                  decoration: const InputDecoration(hintText: 'Search here ..'))),

          Expanded(
            child: BlocBuilder<MoviesSearchBloc, BaseState>(
              builder: (_, state) {
                if (state is InitialState) {
                  return const Center(
                    child: Text('Start search ..'),
                  );
                }

                if (state is ErrorState) {
                  return Center(
                    child: Retry(
                      onRetry: () {
                        context.read<MoviesSearchBloc>().add(OnChange<String>(''));
                      },
                    ),
                  );
                }
                if (state is DataLoadedState<List<Movie>>) {
                  if (state.data.isEmpty) {
                    return const Center(
                      child: Text('Not found any result ..'),
                    );
                  }
                  final items = state.data;
                  return ListView.separated(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = items[index];
                      return MovieSearchCard(movie: item);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),

          // Bloc
        ],
      ),
    );
  }
}
