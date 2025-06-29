import '../entities/genre_entity.dart';
import '../repositories/book_repository.dart';

class FetchGenreUsecase {
  final BookRepository bookRepository;

  FetchGenreUsecase(this.bookRepository);

  Future<List<GenreEntity>> call() async {
    return await bookRepository.getGenres();
  }
}
