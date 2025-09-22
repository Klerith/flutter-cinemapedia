import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
{
  505642: Movie(),
  505643: Movie(),
  505645: Movie(),
  501231: Movie(),
}

*/

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
      // Repositorio de localStorage
      final localStorageRepository = ref.watch(localStorageRepositoryProvider);

      return StorageMoviesNotifier(
        localStorageRepository: localStorageRepository,
      );
    });

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadFavoriteMovies(
      limit: 10,
      offset: page * 10,
    );

    page++;

    final tempMovies = <int, Movie>{};
    for (final movie in movies) {
      // state = { ...state, movie.id: movie }; // no quiero hacer 20 actualizaciones de estate
      tempMovies[movie.id] = movie;
    }

    state = {...state, ...tempMovies};

    return movies;
  }
}
