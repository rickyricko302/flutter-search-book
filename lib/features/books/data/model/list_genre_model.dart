import '../../domain/entities/genre_entity.dart';

class ListGenreModel {
  List<GenreStatistics>? genreStatistics;
  int? totalGenres;

  ListGenreModel({this.genreStatistics, this.totalGenres});

  ListGenreModel.fromJson(Map<String, dynamic> json) {
    if (json['genre_statistics'] != null) {
      genreStatistics = <GenreStatistics>[];
      json['genre_statistics'].forEach((v) {
        genreStatistics!.add(GenreStatistics.fromJson(v));
      });
    }
    totalGenres = json['total_genres'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (genreStatistics != null) {
      data['genre_statistics'] =
          genreStatistics!.map((v) => v.toJson()).toList();
    }
    data['total_genres'] = totalGenres;
    return data;
  }
}

class GenreStatistics {
  int? count;
  String? genre;

  GenreStatistics({this.count, this.genre});

  GenreStatistics.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    genre = json['genre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['genre'] = genre;
    return data;
  }

  GenreEntity toEntity() {
    return GenreEntity(count: count ?? 0, genre: genre ?? '');
  }
}
