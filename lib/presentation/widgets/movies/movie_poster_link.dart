


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MoviePosterLink extends StatelessWidget {

  final Movie movie;

  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/home/0/movie/${ movie.id }'),
      child: ClipRRect(
        borderRadius: BorderRadiusDirectional.circular(20),
        child: FadeIn(child: Image.network(movie.posterPath)),
      ),
    );
  }
}