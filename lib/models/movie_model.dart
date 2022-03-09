import 'dart:convert';

MoviesModel moviesModelFromJson(String str) =>
    MoviesModel.fromJson(json.decode(str));

String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());

class MoviesModel {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  MoviesModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  DateTime? releaseDate;
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? voteCount;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String? posterPath;
  double? voteAverage;
  bool? video;
  int? id;
  String? title;
  String? overview;
  double? popularity;
  MediaType? mediaType;
  DateTime? firstAirDate;
  String? name;
  List<String>? originCountry;
  String? originalName;

  Result({
    this.releaseDate,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.voteCount,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.voteAverage,
    this.video,
    this.id,
    this.title,
    this.overview,
    this.popularity,
    this.mediaType,
    this.firstAirDate,
    this.name,
    this.originCountry,
    this.originalName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        voteCount: json["vote_count"],
        originalLanguage:
            originalLanguageValues.map![json["original_language"]],
        originalTitle: json["original_title"] ?? '',
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        video: json["video"] ?? false,
        id: json["id"],
        title: json["title"] ?? '',
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        mediaType: mediaTypeValues.map![json["media_type"]],
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        name: json["name"] ?? '',
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"].map((x) => x)),
        originalName: json["original_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "release_date": releaseDate == null
            ? null
            : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "adult": adult ?? false,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "vote_count": voteCount,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle ?? '',
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "video": video ?? false,
        "id": id,
        "title": title ?? '',
        "overview": overview,
        "popularity": popularity,
        "media_type": mediaTypeValues.reverse[mediaType],
        "first_air_date": firstAirDate == null
            ? null
            : "${firstAirDate?.year.toString().padLeft(4, '0')}-${firstAirDate?.month.toString().padLeft(2, '0')}-${firstAirDate?.day.toString().padLeft(2, '0')}",
        "name": name ?? '',
        "origin_country": originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_name": originalName ?? '',
      };
}

enum MediaType { movie, tv }

final mediaTypeValues =
    EnumValues({"movie": MediaType.movie, "tv": MediaType.tv});

enum OriginalLanguage { en, ko, it, ja }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.en,
  "it": OriginalLanguage.it,
  "ja": OriginalLanguage.ja,
  "ko": OriginalLanguage.ko
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap!.isEmpty) {
      reverseMap = map!.map((k, v) => MapEntry(v, k));
    }
    return reverseMap ?? {};
  }
}
