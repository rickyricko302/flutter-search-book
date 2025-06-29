class FilterEntity {
  final String genre;
  final String year;
  final String keyword;
  final String sort;
  final int page;

  FilterEntity({
    required this.genre,
    required this.year,
    required this.keyword,
    required this.sort,
    required this.page,
  });

  FilterEntity copyWith({
    String? genre,
    String? year,
    String? keyword,
    String? sort,
    int? page,
  }) {
    return FilterEntity(
      genre: genre ?? this.genre,
      year: year ?? this.year,
      keyword: keyword ?? this.keyword,
      sort: sort ?? this.sort,
      page: page ?? this.page,
    );
  }
}
