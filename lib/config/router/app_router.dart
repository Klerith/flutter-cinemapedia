import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

// import 'package:cinemapedia/presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0', 
  routes: [
  
    GoRoute(
        path: '/home/:page',
        builder: (BuildContext context, GoRouterState state) {
          final pageIndex = state.params['page'] ?? '0';
          return HomeScreen( pageIndex: int.parse( pageIndex ));
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

]);
