import 'package:cariin_buku/features/books/data/model/filter_model.dart';

import 'package:cariin_buku/features/books/data/model/list_book_model.dart';

import '../../../../core/error/exception.dart';
import '../../domain/entities/genre_entity.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_remote_datasource.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource bookRemoteDataSource;
  BookRepositoryImpl({required this.bookRemoteDataSource});

  @override
  Future<List<GenreEntity>> getGenres() async {
    try {
      final listGenre = await bookRemoteDataSource.getGenres();
      if (listGenre.genreStatistics == null) {
        return [];
      }
      return listGenre.genreStatistics!
          .map((genre) => genre.toEntity())
          .toList()
        ..add(GenreEntity(count: 0, genre: 'Semua Genre'));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ListBookModel> searchBooks({required FilterModel filterModel}) {
    try {
      return bookRemoteDataSource.searchBooks(filterModel: filterModel);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
