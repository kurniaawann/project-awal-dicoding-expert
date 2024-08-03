import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv_detail.dart';
import 'package:equatable/equatable.dart';

class SerialTvTable extends Equatable {
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

  const SerialTvTable({
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

  factory SerialTvTable.fromEntity(SerialTvDetail serialtv) => SerialTvTable(
        id: serialtv.id,
        name: serialtv.name,
        overview: serialtv.overview,
        posterPath: serialtv.posterPath,
      );

  factory SerialTvTable.fromMap(Map<String, dynamic> map) => SerialTvTable(
        id: map['id'],
        name: map['name'],
        overview: map['overview'],
        posterPath: map['posterPath'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  SerialTv toEntity() => SerialTv.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
