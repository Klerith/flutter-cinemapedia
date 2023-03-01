import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularView extends ConsumerWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    
    final popularMovies = ref.watch( popularMoviesProvider );
    
    if ( popularMovies.isEmpty ) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    
    return Scaffold(
      body: MovieMasonry(
        loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
        movies: popularMovies
      )
    );
  }
}
