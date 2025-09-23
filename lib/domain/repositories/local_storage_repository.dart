import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavoriteMovie(Movie movie);

  Future<bool> isFavoriteMovie(int movieId);

  Future<List<Movie>> loadFavoriteMovies({int limit = 10, int offset = 0});
}
