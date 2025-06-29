import '../../domain/entities/filter_entity.dart';

class FilterModel {
  final String genre;
  final String year;
  final String keyword;
  final String sort;
  final int page;

  FilterModel({
    required this.genre,
    required this.year,
    required this.keyword,
    required this.sort,
    required this.page,
  });

  factory FilterModel.fromEntity(FilterEntity entity) {
    return FilterModel(
      genre: entity.genre == 'Semua Genre' ? '' : entity.genre,
      year: entity.year == 'Semua Tahun' ? '' : entity.year,
      keyword: entity.keyword,
      sort: entity.sort,
      page: entity.page,
    );
  }
}
