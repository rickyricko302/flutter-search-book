import '../../data/model/filter_model.dart';
import '../../data/model/list_book_model.dart';
import '../entities/genre_entity.dart';

abstract class BookRepository {
  Future<List<GenreEntity>> getGenres();
  Future<ListBookModel> searchBooks({required FilterModel filterModel});
}
