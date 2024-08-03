import 'package:ditonton/domain/entities_serial_tv/genre_serial_tv.dart';
import 'package:equatable/equatable.dart';

class SerialTvDetail extends Equatable {
  const SerialTvDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.runtime,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<GenreSerialTv> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final int runtime;
  final String name;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        firstAirDate,
        runtime,
        name,
        voteAverage,
        voteCount,
      ];
}
