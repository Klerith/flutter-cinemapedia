import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PopularView extends StatelessWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: MovieMasonry(
        // loadNextPage: loadNextPage,
        movies: []
      )
    );
  }
}
