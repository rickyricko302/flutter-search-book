class GenreEntity {
  final int count;
  final String genre;

  GenreEntity({required this.count, required this.genre});

  @override
  String toString() {
    return 'GenreEntity(count: $count, genre: $genre)';
  }
}
