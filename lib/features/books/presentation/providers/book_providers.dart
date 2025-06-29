import 'package:cariin_buku/core/network/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/book_remote_datasource.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/usecase/fetch_genre_usecase.dart';
import '../../domain/usecase/fetch_search_book_usecase.dart';

part 'book_providers.g.dart';

@riverpod
BookRemoteDataSource bookRemoteDataSource(Ref ref) {
  final ApiService apiService = ApiService(
    'https://bukuacak-9bdcb4ef2605.herokuapp.com/api/v1',
  );
  return BookRemoteDataSource(apiService: apiService);
}

@riverpod
BookRepository bookRepository(Ref ref) {
  return BookRepositoryImpl(
    bookRemoteDataSource: ref.read(bookRemoteDataSourceProvider),
  );
}

@riverpod
FetchGenreUsecase fetchGenreUsecase(Ref ref) {
  return FetchGenreUsecase(ref.read(bookRepositoryProvider));
}

@riverpod
FetchSearchBookUsecase fetchSearchBookUsecase(Ref ref) {
  return FetchSearchBookUsecase(ref.read(bookRepositoryProvider));
}

@Riverpod(keepAlive: true)
List<String> listYear(Ref ref) {
  return [
    'Semua Tahun',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
  ];
}

@Riverpod(keepAlive: true)
List<String> sortBy(Ref ref) {
  return ['Terbaru', 'Terlama', 'A ke Z', 'Z ke A', 'Termurah', 'Termahal'];
}
