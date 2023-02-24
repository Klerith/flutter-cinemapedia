import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

import '../../presentation/views/views.dart';
// import 'package:cinemapedia/presentation/views/views.dart';

//! Keep alive 
HomeView? preservedHomeview;

final appRouter = GoRouter(
  // initialLocation: '/', 
  restorationScopeId: 'router',
  routes: [
  
  // Bottom Navigation Bar
  ShellRoute(
    
    builder: (BuildContext context, GoRouterState state, Widget child) {
      return HomeScreen( childView: child );
      // return const HomeScreen();
    },
    routes: <RouteBase>[
      // !funcionando
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          preservedHomeview ??= const HomeView();
          return preservedHomeview!;
          // return const SizedBox();
        },
        routes: [
          GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              final movieId = state.params['id'] ?? 'no-id';

              return MovieScreen(movieId: movieId);
            },
          ),
        ]
      ),

      GoRoute(
        path: '/favorites',
        builder: (BuildContext context, GoRouterState state) {
          return const FavoritesView();
          // return const SizedBox();
        },
      ),
    ],
  ),



  // GoRoute(
  //     path: '/movie/:id',
  //     name: MovieScreen.name,
  //     builder: (context, state) {
  //       final movieId = state.params['id'] ?? 'no-id';

  //       return MovieScreen(movieId: movieId);
  //     },
  //   ),
  


  // GoRoute(
  //     path: '/',
  //     name: HomeScreen.name,
  //     builder: (context, state) => const HomeScreen(),
  //     routes: [
        // GoRoute(
        //   path: 'movie/:id',
        //   name: MovieScreen.name,
        //   builder: (context, state) {
        //     final movieId = state.params['id'] ?? 'no-id';

        //     return MovieScreen(movieId: movieId);
        //   },
        // ),
  //     ]),
]);
