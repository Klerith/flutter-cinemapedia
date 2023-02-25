import 'package:isar/isar.dart';


import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';


class IsarDatasource extends LocalStorageDatasource{

  late Future<Isar> db;

  IsarDatasource(){
    db = openDB();
  }

  Future<Isar> openDB() async {

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> isMovieFavorite(Movie movieId) {
    // TODO: implement isMovieFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;
    // isar.writeTxnSync(() => isar.movies.putSync(movie));
    
    // Actual Toggle
    final favoriteMovie =  await isar.movies
      .filter()
      .idEqualTo(movie.id)
      .findFirst();
    
    if ( favoriteMovie != null ) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!) );
      return;
    }
    
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }



}