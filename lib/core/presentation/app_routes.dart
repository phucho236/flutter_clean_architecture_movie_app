import 'package:clean_arch_movie_app/features/auth/presentation/pages/splat.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/pages/movie_details.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/pages/movies_page.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/pages/movies_search.dart';

class AppRoutes {
  static get routes => {
        SplatPage.route: (context) => const SplatPage(),
        MoviesPage.route: (context) => const MoviesPage(),
        MovieDetails.route: (context) => const MovieDetails(),
        MoviesSearchRoot.route: (context) => const MoviesSearchRoot(),
      };
}
