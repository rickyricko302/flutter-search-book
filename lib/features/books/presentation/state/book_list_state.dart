import 'package:cariin_buku/features/books/domain/entities/book_entity.dart';

class BookListState {
  final List<BookEntity> books;
  final PaginationEntity pagination;
  final bool isLoadMoreLoading;

  BookListState({
    required this.books,
    required this.pagination,
    required this.isLoadMoreLoading,
  });

  BookListState copyWith({
    List<BookEntity>? books,
    PaginationEntity? pagination,
    bool? isLoadMoreLoading,
  }) {
    return BookListState(
      books: books ?? this.books,
      pagination: pagination ?? this.pagination,
      isLoadMoreLoading: isLoadMoreLoading ?? this.isLoadMoreLoading,
    );
  }
}
