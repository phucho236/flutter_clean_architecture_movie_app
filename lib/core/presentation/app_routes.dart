import 'package:clean_arch_movie_app/features/auth/presentation/pages/login_page.dart';
import 'package:clean_arch_movie_app/features/list_item/items_page.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/pages/movie_details.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/pages/movies_page.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/pages/movies_search.dart';

class AppRoutes {
  static get routes => {
        LoginPage.route: (context) => const LoginPage(),
        MoviesPage.route: (context) => const MoviesPage(),
        MovieDetails.route: (context) => const MovieDetails(),
        MoviesSearchRoot.route: (context) => const MoviesSearchRoot(),
        ItemsPage.route: (context) => const ItemsPage(),
      };
}
