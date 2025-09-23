import 'package:drift/drift.dart' as drift;
import 'package:cinemapedia/config/database/database.dart';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class DriftDatasource extends LocalStorageDatasource {
  final AppDatabase database;

  DriftDatasource([AppDatabase? databaseToUse])
    : database = databaseToUse ?? db;

  @override
  Future<bool> isFavoriteMovie(int movieId) async {
    // Construir el query
    final query = database.select(database.favoriteMovies)
      ..where((table) => table.movieId.equals(movieId));

    // Ejecutar el query
    final favoriteMovie = await query.getSingleOrNull();

    // Retornar el resultado
    return favoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, int offset = 0}) {
    // TODO: implement loadFavoriteMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isFavorite = await isFavoriteMovie(movie.id);

    if (isFavorite) {
      final deleteQuery = database.delete(database.favoriteMovies)
        ..where((table) => table.movieId.equals(movie.id));

      await deleteQuery.go();
      return;
    }

    await database
        .into(database.favoriteMovies)
        .insert(
          FavoriteMoviesCompanion.insert(
            movieId: movie.id,
            backdropPath: movie.backdropPath,
            originalTitle: movie.originalTitle,
            posterPath: movie.posterPath,
            title: movie.title,
            voteAverage: drift.Value(movie.voteAverage),
          ),
        );
  }
}
