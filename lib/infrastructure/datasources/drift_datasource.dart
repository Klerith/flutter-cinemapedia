import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/config/database/database.dart';
import 'package:drift/drift.dart' as drift;

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
    return favoriteMovie !=
        null; // Si el resultado es null, la movie no está en favoritos
  }

  @override
  Future<List<Movie>> loadFavoriteMovies(
      {int limit = 10, int offset = 0}) async {
    // Construir el query
    final query = database.select(database.favoriteMovies)
      ..limit(limit, offset: offset);

    // Ejecutar el query
    final favoriteMoviesRows = await query.get();

    // Convertimos cada fila de la base de datos a una entidad Movie
    final movies = favoriteMoviesRows
        .map((row) => Movie(
              id: row.movieId,
              title: row.title,
              posterPath: row.posterPath,
              backdropPath: row.backdropPath,
              overview: '',
              voteAverage: row.voteAverage,
              releaseDate: DateTime.now(),
              originalTitle: row.originalTitle,
              genreIds: const [],
              popularity: 0,
              adult: false,
              originalLanguage: '',
              video: false,
              voteCount: 0,
            ))
        .toList();

    return movies;
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movieId) async {
    final isFavorite = await isFavoriteMovie(movieId.id);

    if (isFavorite) {
      final deleteQuery = database.delete(database.favoriteMovies)
        ..where((table) => table.id.equals(movieId.id));
      await deleteQuery.go();
      return;
    }

    // Insertar la película como favorita en la base de datos
    await database.into(database.favoriteMovies).insert(
          FavoriteMoviesCompanion.insert(
            movieId: movieId.id,
            title: movieId.title,
            posterPath: movieId.posterPath,
            backdropPath: movieId.backdropPath,
            originalTitle: movieId.originalTitle,
            voteAverage: drift.Value(movieId.voteAverage),
          ),
        );
  }
}
