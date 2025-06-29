import '../../data/model/filter_model.dart';
import '../../data/model/list_book_model.dart';
import '../repositories/book_repository.dart';

class FetchSearchBookUsecase {
  final BookRepository bookRepository;

  FetchSearchBookUsecase(this.bookRepository);

  Future<ListBookModel> call({required FilterModel filterModel}) async {
    return await bookRepository.searchBooks(filterModel: filterModel);
  }
}
