import 'dart:developer';

import 'package:cariin_buku/features/books/data/model/filter_model.dart';
import 'package:cariin_buku/features/books/domain/entities/book_entity.dart';
import 'package:cariin_buku/features/books/presentation/state/book_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/filter_entity.dart';
import '../../domain/entities/genre_entity.dart';
import 'book_providers.dart';

part 'book_notifiers.g.dart';

@Riverpod(keepAlive: true)
class ListGenre extends _$ListGenre {
  @override
  FutureOr<List<GenreEntity>> build() async {
    return await fetchGenres();
  }

  Future<List<GenreEntity>> fetchGenres() async {
    state = const AsyncValue.loading();
    try {
      final genres = await ref.read(fetchGenreUsecaseProvider)();
      state = AsyncValue.data(genres);
      return genres;
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
class Filter extends _$Filter {
  @override
  FilterEntity build() {
    return FilterEntity(
      genre: 'Semua Genre',
      year: 'Semua Tahun',
      keyword: '',
      sort: 'Terbaru',
      page: 1,
    );
  }

  void selectGenre(String genre) {
    state = state.copyWith(genre: genre);
  }

  void selectYear(String year) {
    state = state.copyWith(year: year);
  }

  void setKeyword(String keyword) {
    state = state.copyWith(keyword: keyword);
  }

  void selectSort(String sort) {
    state = state.copyWith(sort: sort);
  }

  void selectPage(int page) {
    state = state.copyWith(page: page);
  }

  void reset() {
    state = FilterEntity(
      genre: 'Semua Genre',
      year: 'Semua Tahun',
      keyword: '',
      sort: 'Terbaru',
      page: 1,
    );
  }
}

@riverpod
class IsSearchBarSticky extends _$IsSearchBarSticky {
  @override
  bool build() {
    return false;
  }

  void setSticky(bool isSticky) {
    state = isSticky;
    log(state.toString(), name: 'IsSearchBarSticky');
  }
}

@riverpod
class SearchBook extends _$SearchBook {
  @override
  FutureOr<BookListState> build() async {
    final fetchSearchBookUsecase = ref.watch(fetchSearchBookUsecaseProvider);
    final filter = ref.watch(filterProvider);
    final listBookModel = await fetchSearchBookUsecase(
      filterModel: FilterModel.fromEntity(filter),
    );
    List<BookEntity> books =
        listBookModel.books.map((book) => book.toEntity()).toList();
    PaginationEntity pagination = listBookModel.pagination.toEntity();
    return BookListState(
      books: books,
      pagination: pagination,
      isLoadMoreLoading: false,
    );
  }

  void loadMore() async {
    if (state.isLoading || !state.hasValue) return;
    final bool hasNextPage = state.value?.pagination.hasNextPage ?? false;
    if (hasNextPage) {
      // set loader load more
      state = AsyncData(state.value!.copyWith(isLoadMoreLoading: true));
      final nextPage = ref.read(filterProvider).page + 1;
      final fetchSearchBookUsecase = ref.read(fetchSearchBookUsecaseProvider);
      final filter = ref.read(filterProvider);
      final listBookModel = await fetchSearchBookUsecase(
        filterModel: FilterModel.fromEntity(filter.copyWith(page: nextPage)),
      );
      List<BookEntity> books =
          listBookModel.books.map((book) => book.toEntity()).toList();
      PaginationEntity pagination = listBookModel.pagination.toEntity();
      BookListState newState = state.value!.copyWith(
        books: [...state.value!.books, ...books],
        pagination: pagination,
        isLoadMoreLoading: false,
      );
      state = AsyncData(newState);
    }
  }
}
