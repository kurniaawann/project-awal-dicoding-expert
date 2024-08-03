import 'package:ditonton/data/models_serial_tv/genre_serial_tv_model.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv_detail.dart';
import 'package:equatable/equatable.dart';

class SerialTvDetailResponse extends Equatable {
  const SerialTvDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.name,
    required this.runtime,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<dynamic>? createdBy;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<GenreModelSerialTv> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String lastAirDate;
  final String name;
  final int runtime;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  factory SerialTvDetailResponse.fromJson(Map<String, dynamic> json) =>
      SerialTvDetailResponse(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] as String?,
        createdBy: json["created_by"] != null
            ? List<dynamic>.from(json["created_by"].map((x) => x))
            : null,
        episodeRunTime: json["episode_run_time"] != null
            ? List<int>.from(json["episode_run_time"].map((x) => x))
            : [],
        firstAirDate: json["firstAirDate"] ?? "",
        genres: List<GenreModelSerialTv>.from(
            json["genres"].map((x) => GenreModelSerialTv.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: json["lastAirDate"] ?? "",
        name: json["name"],
        runtime: json["runtime"] ?? 0,
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry:
            List<String>.from(json["originCountry"]?.map((x) => x) ?? []),
        originalLanguage: json["original_language"],
        originalName: json["originalName"] ?? '',
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        posterPath: json["poster_path"],
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "created_by": List<dynamic>.from(genres.map((x) => x)),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "firstAirDate": firstAirDate,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "lastAirDate": lastAirDate,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "originCountry ": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "originalName": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  SerialTvDetail toEntity() {
    return SerialTvDetail(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      firstAirDate: firstAirDate,
      runtime: runtime,
      name: name,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
