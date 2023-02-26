import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider(
  (ref) {
    return LocalStorageRepositoryImpl( IsarDatasource() );
  }
);



final favoritesMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {

  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return StorageMoviesNotifier(
    localStorageRepository: localStorageRepository,
    initialMovies: {},
  );
});



class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {

  final Map<int,Movie> initialMovies;
  final LocalStorageRepository localStorageRepository;

  int page = 0;

  StorageMoviesNotifier({
    this.initialMovies = const{},
    required this.localStorageRepository,
  }): super( initialMovies );

  Future<List<Movie>> loadNextPage() async{

    final movies = await localStorageRepository.loadMovies(offset: page * 10, limit: 20);
    page++;

    // actualizará 10 veces el state
    // movies.forEach((movie) {
    //   state[movie.id] = movie;
    // });
    final tempMoviesMap = <int, Movie>{};
    for (var movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }
    // state.addAll(tempMoviesMap);
    state = {...state, ...tempMoviesMap};

    return movies;
  }

  Future<void> toggleFavorite( Movie movie ) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if ( isMovieInFavorites ) {
      state.remove(movie.id);
      state = {...state };
    } else {
      state = { ...state, movie.id: movie };
    }

  }


}