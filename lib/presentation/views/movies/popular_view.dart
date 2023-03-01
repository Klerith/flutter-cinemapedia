import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularView extends ConsumerStatefulWidget {
  const PopularView({super.key});

  @override
  PopularViewState createState() => PopularViewState();
}

class PopularViewState extends ConsumerState<PopularView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context ) {
    super.build(context);
    
    final popularMovies = ref.watch( popularMoviesProvider );
    
    if ( popularMovies.isEmpty ) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    
    return Scaffold(
      body: MovieMasonry(
        loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
        movies: popularMovies
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
