import 'package:equatable/equatable.dart';

class SerialTv extends Equatable {
  const SerialTv({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  const SerialTv.watchlist({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originCountry,
    this.originalName,
    this.popularity,
    this.firstAirDate,
    this.voteAverage,
    this.voteCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int id;
  final List<String>? originCountry;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? firstAirDate;
  final String? name;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originCountry,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount
      ];
}
