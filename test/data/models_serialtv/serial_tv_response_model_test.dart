import 'dart:convert';

import 'package:ditonton/data/models_serial_tv/model_serial_tv.dart';
import 'package:ditonton/data/models_serial_tv/serial_tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tSerialTvModel = SerialTvModel(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3, 4],
    id: 1,
    originCountry: ['DE'],
    originalName: 'Original name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    firstAirDate: "",
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
  );
  const tSerialTvResponseModel =
      SerialTvResponse(serialTvList: <SerialTvModel>[tSerialTvModel]);

  group('from json serial tv', () {
    test('should return a valid model from JSON', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json
          .decode(readJson('dummy_data_serial_tv/serial_tv_airing_today.json'));

      //act
      final result = SerialTvResponse.fromJson(jsonMap);

      //assert
      expect(result, tSerialTvResponseModel);
      //assert
    });
  });

  group('to json', () {
    test('should return a JSON map containing proper data', () async {
//arrange

//act
      final result = tSerialTvResponseModel.toJson();
//assert
      final expectedJsonMap = {
        "results": [
          {
            'adult': false,
            'backdrop_path': '/path.jpg',
            'genre_ids': [1, 2, 3, 4],
            'id': 1,
            'originCountry ': [1, 2, 3, 4],
            'originalName': 'Original name',
            'overview': 'Overview',
            'popularity': 1.0,
            'poster_path': '/path.jpg',
            'firstAirDate': '',
            'name': 'name',
            'vote_average': 1.0,
            'vote_count': 1,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
