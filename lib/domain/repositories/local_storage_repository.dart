import 'package:cinemapedia/domain/entities/movie.dart';



abstract class LocalStorageRepository {

  Future<void> toggleFavorite( Movie movie );
  
  Future<void> isMovieFavorite( Movie movieId );

}