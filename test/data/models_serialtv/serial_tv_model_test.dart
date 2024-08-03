import 'package:ditonton/data/models_serial_tv/model_serial_tv.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSerialTvModel = SerialTvModel(
    adult: false,
    backdropPath: "backdropPath",
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['DE'],
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  const tSerialTv = SerialTv(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['DE'],
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Serial Tv entity', () async {
    final result = tSerialTvModel.toEntity();
    expect(result, tSerialTv);
  });
}
