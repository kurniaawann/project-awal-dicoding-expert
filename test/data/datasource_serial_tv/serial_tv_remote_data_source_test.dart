import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources_serial_tv/serial_tv_remote_data_source.dart';
import 'package:ditonton/data/models_serial_tv/serial_tv_detail.dart';
import 'package:ditonton/data/models_serial_tv/serial_tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers_serial_tv/test_helper_serial_tv.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late SerialTvRemoteDataSourceImpl dataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = SerialTvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Airing Today Serial Tv', () {
    final tSerialTvList = SerialTvResponse.fromJson(jsonDecode(
            readJson('dummy_data_serial_tv/serial_tv_airing_today.json')))
        .serialTvList;

    test('should return list of Serial Tv Model when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data_serial_tv/serial_tv_airing_today.json'),
              200));

      //act
      final result = await dataSourceImpl.getNowPlayingSerialTv();
      //assert
      expect(result, equals(tSerialTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //
      final call = dataSourceImpl.getNowPlayingSerialTv();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group("get Popular Serial Tv", () {
    final tSerialTvList = SerialTvResponse.fromJson(json
            .decode(readJson('dummy_data_serial_tv/serial_tv_popular.json')))
        .serialTvList;

    test('should return list of movies when response is success (200)',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data_serial_tv/serial_tv_popular.json'), 200));
      //act
      final result = await dataSourceImpl.getPopularSerialTv();
      //assert
      expect(result, tSerialTvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      //act
      final call = dataSourceImpl.getPopularSerialTv();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rate Serial Tv', () {
    final tSerialTvList = SerialTvResponse.fromJson(json
            .decode(readJson('dummy_data_serial_tv/top_rated_serial_tv.json')))
        .serialTvList;

    test('should return list of serial tv when response code is 200', () async {
      //arrage
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data_serial_tv/top_rated_serial_tv.json'), 200));

      //act
      final result = await dataSourceImpl.getTopRatedSerialTv();
      //assert
      expect(result, tSerialTvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 400));
      //act
      final call = dataSourceImpl.getTopRatedSerialTv();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Serial Tv Detail', () {
    const tId = 1;
    final tSerialTvDetail = SerialTvDetailResponse.fromJson(
        json.decode(readJson('dummy_data_serial_tv/serial_tv_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data_serial_tv/serial_tv_detail.json'), 200));

      // Act
      final result = await dataSourceImpl.getSerialTvDetail(tId);

      // Assert
      expect(result, equals(tSerialTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSourceImpl.getSerialTvDetail(tId);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Serial Tv Recommendations', () {
    final tSerialTvList = SerialTvResponse.fromJson(json.decode(
            readJson('dummy_data_serial_tv/serial_tv_recommendations.json')))
        .serialTvList;
    const tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      //arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data_serial_tv/serial_tv_recommendations.json'),
              200));

      //act
      final result = await dataSourceImpl.getSerialTvRecomendations(tId);
      //assert
      expect(result, equals(tSerialTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.getSerialTvRecomendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search Serial Tv', () {
    final tSearchResult = SerialTvResponse.fromJson(json.decode(
            readJson('dummy_data_serial_tv/search_tagesschau_serial_tv.json')))
        .serialTvList;
    const tQuery = 'tagesschau';

    test('should return list of movies when response code is 200', () async {
      //arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data_serial_tv/search_tagesschau_serial_tv.json'),
              200));

      //act
      final result = await dataSourceImpl.searchSerialTv(tQuery);

      //assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSourceImpl.searchSerialTv(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
