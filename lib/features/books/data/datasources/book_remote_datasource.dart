import 'dart:developer';
import 'dart:io';

import 'package:cariin_buku/core/network/api_service.dart';
import 'package:cariin_buku/core/error/exception.dart';
import 'package:cariin_buku/features/books/data/model/list_genre_model.dart';

import '../model/filter_model.dart';
import '../model/list_book_model.dart';

class BookRemoteDataSource {
  final ApiService apiService;
  BookRemoteDataSource({required this.apiService});

  /// Fetches the list of book genres from the API.
  Future<ListGenreModel> getGenres() async {
    try {
      final data = await apiService.getRequest('/stats/genre');
      return ListGenreModel.fromJson(data);
    } on SocketException {
      throw ServerException('No Internet connection');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// Searches for books based on the provided [filterModel].
  Future<ListBookModel> searchBooks({required FilterModel filterModel}) async {
    try {
      final data = await apiService.getRequest(
        '/book?page=${filterModel.page}&year=${filterModel.year}&genre=${filterModel.genre}&keyword=${filterModel.keyword}',
      );
      log('Search Books Data: $data');
      return ListBookModel.fromJson(data);
    } on SocketException {
      throw ServerException('No Internet connection');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
