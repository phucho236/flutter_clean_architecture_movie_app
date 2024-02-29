import 'package:clean_arch_movie_app/core/presentation/storage.dart';
import 'package:clean_arch_movie_app/features/movies/presentation/pages/movies_page.dart';
import 'package:flutter/material.dart';

class SplatPage extends StatefulWidget {
  static String route = "/";
  const SplatPage({Key? key}) : super(key: key);

  @override
  State<SplatPage> createState() => _SplatPageState();
}

class _SplatPageState extends State<SplatPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Storage.init().then((value) {
      Navigator.pushNamed(context, MoviesPage.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
