import 'package:cinemapedia/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl( IsarDatasource() );
});

