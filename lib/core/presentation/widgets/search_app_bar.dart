import 'package:clean_arch_movie_app/features/movies/presentation/pages/movies_search.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
/*
          SizedBox(
              width: 80,
              child: ,
          // Spacer(),
*/

          const Text('WOOKIE \nMOVIES', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          const Icon(Icons.search, size: 25),
          Expanded(
              child: TextField(
            onTap: () => Navigator.of(context).pushNamed(
              MoviesSearchRoot.route,
            ),
            readOnly: true,
            decoration: const InputDecoration(focusedBorder: OutlineInputBorder(), border: OutlineInputBorder()),
          ))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
