import 'package:cinemapedia/domain/entities/movie.dart';


abstract class MovieDatasource {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

}