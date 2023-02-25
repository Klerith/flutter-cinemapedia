import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider(
  (ref) {
    return LocalStorageRepositoryImpl( IsarDatasource() );
  }
);

final favoritesMoviesProvider = StateNotifierProvider((ref) {

  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return StorageMoviesNotifier(
    toggleMovieCallback: localStorageRepository.toggleFavorite,
    initialMovies: {},
  );
});


typedef ToggleMovieCallback = Future<void> Function(Movie movie);

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {

  final Map<int,Movie> initialMovies;
  final ToggleMovieCallback toggleMovieCallback;

  StorageMoviesNotifier({
    this.initialMovies = const{},
    required this.toggleMovieCallback,
  }): super( initialMovies );

  Future<void> toggleFavorite( Movie movie ) async {
    await toggleMovieCallback(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if ( isMovieInFavorites ) {
      state.remove(movie.id);
    } else {
      state = { ...state, movie.id: movie };
    }

  }

}