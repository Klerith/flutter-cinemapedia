import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider);

    // return Scaffold(
    //   body: ListView.builder(
    //     itemBuilder: (context, index) {
    //       final movie = ref
    //           .watch(favoriteMoviesProvider)
    //           .values
    //           .toList()[index];

    //       return ListTile(title: Text(movie.title));
    //     },
    //     itemCount: favoriteMovies.keys.length,
    //   ),
    // );
    if (favoriteMovies.isEmpty) {
      final textTheme = Theme.of(context).textTheme;
      final colorPrimary = Theme.of(context).colorScheme.primary;
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 100, color: colorPrimary),
              Text(
                'No tienes películas favoritas',
                style: textTheme.titleMedium,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: favoriteMovies.values.toList(),
        loadNextPage: () =>
            ref.read(favoriteMoviesProvider.notifier).loadNextPage(),
      ),
    );
  }
}
