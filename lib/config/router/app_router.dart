import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/', 
  routes: [
  
  // Bottom Navigation Bar
  ShellRoute(
    builder: (BuildContext context, GoRouterState state, Widget child) {
      return HomeScreen( childView: child );
    },
    routes: <RouteBase>[
      
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),

      GoRoute(
        path: '/favorites',
        builder: (BuildContext context, GoRouterState state) {
          return const FavoritesView();
        },
      ),
    ],
  ),


  // GoRoute(
  //     path: '/',
  //     name: HomeScreen.name,
  //     builder: (context, state) => const HomeScreen(),
  //     routes: [
  //       GoRoute(
  //         path: 'movie/:id',
  //         name: MovieScreen.name,
  //         builder: (context, state) {
  //           final movieId = state.params['id'] ?? 'no-id';

  //           return MovieScreen(movieId: movieId);
  //         },
  //       ),
  //     ]),
]);
