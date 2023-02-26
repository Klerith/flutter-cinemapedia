import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';


class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // ref.read(favoritesMoviesProvider.notifier).loadNextPage();
    loadNextPage();
  }

  void loadNextPage() async {
    if ( isLastPage || isLoading ) return;
    isLoading = true;

    final movies = await ref.read(favoritesMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if ( movies.isEmpty ) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoritesMoviesProvider).values.toList();

    if ( favoriteMovies.isEmpty ) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text('No hay películas en favoritos'),
            Icon( Icons.favorite_outline_sharp, size: 60, color: colors.primary ),
            Text('Ohh no!', style: TextStyle(fontSize: 30, color: colors.primary ) ),
            const Text('No tienes películas favoritas', style: TextStyle(fontSize: 20, color: Colors.black45, ) ),
            const SizedBox(height: 20 ),

            FilledButton.tonal(
              onPressed: (){
                context.go('/home/0');
              }, 
              child: const Text('Empieza a buscar')
            )
          ],
        ),
      );
    }

    return MovieMasonry(
      movies: favoriteMovies,
      loadNextPage: loadNextPage,
    );
  }
}
