import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models_serial_tv/genre_serial_tv_model.dart';
import 'package:ditonton/data/models_serial_tv/model_serial_tv.dart';
import 'package:ditonton/data/models_serial_tv/serial_tv_detail.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories_Serial_Tv/serialtv_repository_impl.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data_serial_tv/dummy_objects_serialtv.dart';
import '../../helpers_serial_tv/test_helper_serial_tv.mocks.dart';

void main() {
  late SerialTvRepositoryImpl repositoryImpl;
  late MockSerialTvRemoteDataSource mockSerialTvRemoteDataSource;
  late MockSerialTvDataSource mockLocalDataSource;

  setUp(() {
    mockSerialTvRemoteDataSource = MockSerialTvRemoteDataSource();
    mockLocalDataSource = MockSerialTvDataSource();
    repositoryImpl = SerialTvRepositoryImpl(
        remoteDataSource: mockSerialTvRemoteDataSource,
        localDataSource: mockLocalDataSource);
  });

  const tSerialTvModel = SerialTvModel(
    adult: false,
    backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
    genreIds: [10763],
    id: 94722,
    originCountry: ['DE'],
    originalName: "Tagesschau",
    overview:
        "German daily news program, the oldest still existing program on German television.",
    popularity: 3538.017,
    posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
    firstAirDate: "1952-12-26",
    name: "Tagesschau",
    voteAverage: 6.898,
    voteCount: 191,
  );

  const tSerialtv = SerialTv(
    adult: false,
    backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
    genreIds: [10763],
    id: 94722,
    originCountry: ['DE'],
    originalName: "Tagesschau",
    overview:
        "German daily news program, the oldest still existing program on German television.",
    popularity: 3538.017,
    posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
    firstAirDate: "1952-12-26",
    name: "Tagesschau",
    voteAverage: 6.898,
    voteCount: 191,
  );

  final tSerialTvModelList = <SerialTvModel>[tSerialTvModel];
  final tSerialTvList = <SerialTv>[tSerialtv];

  group("Now Playing Movies", () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockSerialTvRemoteDataSource.getNowPlayingSerialTv())
          .thenAnswer((_) async => tSerialTvModelList);
      //act
      final result = await repositoryImpl.getNowPlayingSerialTv();
      //assert
      verify(mockSerialTvRemoteDataSource.getNowPlayingSerialTv());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockSerialTvRemoteDataSource.getNowPlayingSerialTv())
          .thenThrow(ServerException());
      //act
      final result = await repositoryImpl.getNowPlayingSerialTv();
      //assert
      verify(mockSerialTvRemoteDataSource.getNowPlayingSerialTv());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      //arrange
      when(mockSerialTvRemoteDataSource.getNowPlayingSerialTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      //act
      final result = await repositoryImpl.getNowPlayingSerialTv();
      //assert
      verify(mockSerialTvRemoteDataSource.getNowPlayingSerialTv());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Serial Tv', () {
    test('should return serial tv list when call to data source is success',
        () async {
      //arrange
      when(mockSerialTvRemoteDataSource.getPopularSerialTv())
          .thenAnswer((_) async => tSerialTvModelList);
      //act
      final result = await repositoryImpl.getPopularSerialTv();
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialTvList);
    });
    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockSerialTvRemoteDataSource.getPopularSerialTv())
          .thenThrow(ServerException());
      // act
      final result = await repositoryImpl.getPopularSerialTv();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockSerialTvRemoteDataSource.getPopularSerialTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repositoryImpl.getPopularSerialTv();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
  group('Top Rated Serial Tv', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockSerialTvRemoteDataSource.getTopRatedSerialTv())
          .thenAnswer((_) async => tSerialTvModelList);
      // act
      final result = await repositoryImpl.getTopRatedSerialTv();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialTvList);
    });
    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockSerialTvRemoteDataSource.getTopRatedSerialTv())
          .thenThrow(ServerException());
      // act
      final result = await repositoryImpl.getTopRatedSerialTv();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockSerialTvRemoteDataSource.getTopRatedSerialTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repositoryImpl.getTopRatedSerialTv();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Serial Tv Detail', () {
    const tId = 1;
    const tSerialTvResponse = SerialTvDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      createdBy: [],
      episodeRunTime: [1, 2, 3],
      firstAirDate: 'firstAirDate',
      genres: [GenreModelSerialTv(id: 1, name: 'News')],
      homepage: "https://google.com",
      id: 1,
      inProduction: true,
      languages: ['de'],
      lastAirDate: 'lastAirDate',
      name: 'name',
      runtime: 0,
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ['DE'],
      originalLanguage: 'DE',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'status',
      tagline: 'tagline',
      type: 'type',
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Serial Tv data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockSerialTvRemoteDataSource.getSerialTvDetail(tId))
          .thenAnswer((_) async => tSerialTvResponse);
      //act
      final result = await repositoryImpl.getSerialTvDetail(tId);
      //assert
      verify(mockSerialTvRemoteDataSource.getSerialTvDetail(tId));
      expect(result, equals(const Right(testSerialTvDetail)));
    });
    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockSerialTvRemoteDataSource.getSerialTvDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repositoryImpl.getSerialTvDetail(tId);
      // assert
      verify(mockSerialTvRemoteDataSource.getSerialTvDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockSerialTvRemoteDataSource.getSerialTvDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repositoryImpl.getSerialTvDetail(tId);
      // assert
      verify(mockSerialTvRemoteDataSource.getSerialTvDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get Serial Tv Recommendations', () {
    final tSerialTvList = <SerialTvModel>[];
    const tId = 1;

    test('should return data (Serial Tv list) when the call is successful',
        () async {
      //arrange
      when(mockSerialTvRemoteDataSource.getSerialTvRecomendations(tId))
          .thenAnswer((_) async => tSerialTvList);
      //act
      final result = await repositoryImpl.getSerialTvRecommendations(tId);
      //assert
      verify(mockSerialTvRemoteDataSource.getSerialTvRecomendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tSerialTvList));
    });
    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockSerialTvRemoteDataSource.getSerialTvRecomendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repositoryImpl.getSerialTvRecommendations(tId);
      // assertbuild runner
      verify(mockSerialTvRemoteDataSource.getSerialTvRecomendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });
    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockSerialTvRemoteDataSource.getSerialTvRecomendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repositoryImpl.getSerialTvRecommendations(tId);
      // assert
      verify(mockSerialTvRemoteDataSource.getSerialTvRecomendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Serial Tv', () {
    const tQuery = "Tagesschau";

    test('should return movie list when call to data source is successful',
        () async {
      //arrange
      when(mockSerialTvRemoteDataSource.searchSerialTv(tQuery))
          .thenAnswer((_) async => tSerialTvModelList);
      //act
      final result = await repositoryImpl.searchSerialTv(tQuery);
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialTvList);
    });
    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockSerialTvRemoteDataSource.searchSerialTv(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repositoryImpl.searchSerialTv(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });
    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockSerialTvRemoteDataSource.searchSerialTv(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repositoryImpl.searchSerialTv(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
  group('save watchlist serial tv', () {
    test('should return success message when saving successful', () async {
      //arrange
      when(mockLocalDataSource.insertWatchlistSerialTv(testSerialTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      //act
      final result =
          await repositoryImpl.saveWatchlistSerialTv(testSerialTvDetail);
      //assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistSerialTv(testSerialTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result =
          await repositoryImpl.saveWatchlistSerialTv(testSerialTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });
  group('remove watchlist Serial tv', () {
    test('should return success message when remove successful', () async {
      //arrange
      when(mockLocalDataSource.removeWatchlistSerialTv(testSerialTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      //act
      final result =
          await repositoryImpl.removeWatchlistSerialTv(testSerialTvDetail);
      //assert
      expect(result, const Right('Removed from watchlist'));
    });
    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistSerialTv(testSerialTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result =
          await repositoryImpl.removeWatchlistSerialTv(testSerialTvDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get wathlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getSerialTvById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repositoryImpl.isAddedToWatchlistSerialTv(tId);
      // assert
      expect(result, false);
    });
  });
  group('get wathlist serialtv', () {
    test('should return list of Serial tv', () async {
      //arrange
      when(mockLocalDataSource.getWatchlistSerialTv())
          .thenAnswer((_) async => [testSerialTvTable]);
      //act
      final result = await repositoryImpl.getWatchlistSerialTv();
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistSerialTv]);
    });
  });
}
