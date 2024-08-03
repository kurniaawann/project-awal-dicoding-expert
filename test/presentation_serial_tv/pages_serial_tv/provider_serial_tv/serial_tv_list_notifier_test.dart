import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_popular_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_top_rated_serial_tv.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'serial_tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingSerialTv, GetPopularSerialTv, GetTopRatedSerialTv])
void main() {
  late SerialTvListNotifier provider;
  late MockGetNowPlayingSerialTv mockGetNowPlayingSerialTv;
  late MockGetPopularSerialTv mockGetPopularSerialTv;
  late MockGetTopRatedSerialTv mockGetTopRatedSerialTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingSerialTv = MockGetNowPlayingSerialTv();
    mockGetPopularSerialTv = MockGetPopularSerialTv();
    mockGetTopRatedSerialTv = MockGetTopRatedSerialTv();
    provider = SerialTvListNotifier(
        getNowPlayingSerialTv: mockGetNowPlayingSerialTv,
        getPopularSerialTv: mockGetPopularSerialTv,
        getTopRatedSerialTv: mockGetTopRatedSerialTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tSerialTv = SerialTv(
    adult: false,
    backdropPath: "backdropPath",
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['DE'],
    originalName: "originalName",
    overview: "overview",
    popularity: 1,
    posterPath: "posterPath",
    firstAirDate: "firstAirDate",
    name: "name",
    voteAverage: 1,
    voteCount: 1,
  );

  final tSerialTvList = <SerialTv>[tSerialTv];

  group('now playing serial tv', () {
    test('initialState should be empty', () {
      expect(provider.nowPlayingState, equals(RequestState.empty));
    });
    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingSerialTv.execute())
          .thenAnswer((_) async => Right(tSerialTvList));
      // act
      provider.fetchNowPlayingSerialTv();
      // assert
      verify(mockGetNowPlayingSerialTv.execute());
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingSerialTv.execute())
          .thenAnswer((_) async => Right(tSerialTvList));
      // act
      provider.fetchNowPlayingSerialTv();
      // assert
      expect(provider.nowPlayingState, RequestState.loading);
    });
    test('should change serialtv when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingSerialTv.execute())
          .thenAnswer((_) async => Right(tSerialTvList));
      // act
      await provider.fetchNowPlayingSerialTv();
      // assert
      expect(provider.nowPlayingState, RequestState.loaded);
      expect(provider.nowPlayingSerialTv, tSerialTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingSerialTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingSerialTv();
      // assert
      expect(provider.nowPlayingState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
  group('popular serial tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularSerialTv.execute())
          .thenAnswer((_) async => Right(tSerialTvList));
      // act
      provider.fetchNowPopularSerialTv();
      // assert
      expect(provider.popularSerialTvState, RequestState.loading);
      // verify(provider.setState(RequestState.loading));
    });
    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularSerialTv.execute())
          .thenAnswer((_) async => Right(tSerialTvList));
      // act
      await provider.fetchNowPopularSerialTv();
      // assert
      expect(provider.popularSerialTvState, RequestState.loaded);
      expect(provider.popularSerialTv, tSerialTvList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularSerialTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPopularSerialTv();
      // assert
      expect(provider.popularSerialTvState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
  group('top rated serial tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedSerialTv.execute())
          .thenAnswer((_) async => Right(tSerialTvList));
      // act
      provider.fetchTopRatedSerialTv();
      // assert
      expect(provider.topRatedSerialTvState, RequestState.loading);
    });
    test('should change serial tv data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedSerialTv.execute())
          .thenAnswer((_) async => Right(tSerialTvList));
      // act
      await provider.fetchTopRatedSerialTv();
      // assert
      expect(provider.topRatedSerialTvState, RequestState.loaded);
      expect(provider.topRatedSerialTv, tSerialTvList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedSerialTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedSerialTv();
      // assert
      expect(provider.topRatedSerialTvState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
