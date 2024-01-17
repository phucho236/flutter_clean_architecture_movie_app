import 'package:clean_arch_movie_app/features/movies/presentation/pages/movie_details.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/pages/movies_page.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/pages/movies_search.dart';

class AppRoutes {
  static get routes => {
        MoviesPage.route: (context) => const MoviesPage(),
        MovieDetails.route: (context) => const MovieDetails(),
        MoviesSearchRoot.route: (context) => const MoviesSearchRoot(),
      };
}
