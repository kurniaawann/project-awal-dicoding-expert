import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_recommendations_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_serial_tv_detail.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_watchlist_status_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/remove_watchlist_serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/save_watchlist_serial_tv.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data_serial_tv/dummy_objects_serialtv.dart';
import 'serial_tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetSerialTvDetail,
  GetSerialTvRecommendations,
  GetWatchListStatusSerialTv,
  SaveWatchlistSerialTv,
  RemoveWatchlistSerialTv,
])
void main() {
  late SerialTvDetailNotifier provider;
  late MockGetSerialTvDetail mockGetSerialTvDetail;
  late MockGetSerialTvRecommendations mockGetSerialTvRecommendations;
  late MockGetWatchListStatusSerialTv mockGetWatchListStatusSerialTv;
  late MockSaveWatchlistSerialTv mockSaveWatchlistSerialTv;
  late MockRemoveWatchlistSerialTv mockRemoveWatchlistSerialTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSerialTvDetail = MockGetSerialTvDetail();
    mockGetSerialTvRecommendations = MockGetSerialTvRecommendations();
    mockGetWatchListStatusSerialTv = MockGetWatchListStatusSerialTv();
    mockSaveWatchlistSerialTv = MockSaveWatchlistSerialTv();
    mockRemoveWatchlistSerialTv = MockRemoveWatchlistSerialTv();
    provider = SerialTvDetailNotifier(
        getSerialTvDetail: mockGetSerialTvDetail,
        getSerialTvRecommendations: mockGetSerialTvRecommendations,
        getWatchListStatusSerialTv: mockGetWatchListStatusSerialTv,
        saveWatchlistSerialTv: mockSaveWatchlistSerialTv,
        removeWatchlistSerialTv: mockRemoveWatchlistSerialTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;
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
  final tSerialTivi = <SerialTv>[tSerialTv];

  void _arrangeUsecase() {
    when(mockGetSerialTvDetail.excute(tId))
        .thenAnswer((_) async => const Right(testSerialTvDetail));

    when(mockGetSerialTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tSerialTivi));
  }

  group('get Serial Tv Detail', () {
    test('should get data from the usecase', () async {
      //arrange
      _arrangeUsecase();
      //act
      await provider.fetchSerialTvDetail(tId);
      //assert
      verify(mockGetSerialTvDetail.excute(tId));
      verify(mockGetSerialTvRecommendations.execute(tId));
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchSerialTvDetail(tId);
      // assert
      expect(provider.serialTvState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change serial tv when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSerialTvDetail(tId);
      // assert
      expect(provider.serialTvState, RequestState.loaded);
      expect(provider.serialTv, testSerialTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSerialTvDetail(tId);
      // assert
      expect(provider.serialTvState, RequestState.loaded);
      expect(provider.serialTvRecommendations, tSerialTivi);
    });
  });

  group("Get Serial Tv Recommendations", () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSerialTvDetail(tId);
      // assert
      verify(mockGetSerialTvRecommendations.execute(tId));
      expect(provider.serialTvRecommendations, tSerialTivi);
    });
    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSerialTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.serialTvRecommendations, tSerialTivi);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetSerialTvDetail.excute(tId))
          .thenAnswer((_) async => const Right(testSerialTvDetail));
      when(mockGetSerialTvRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchSerialTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });

    group('watchlist serial tv', () {
      test('should get the watchlist status', () async {
        // arrange
        when(mockGetWatchListStatusSerialTv.execute(1))
            .thenAnswer((_) async => true);
        // act
        await provider.loadWatchlistStatusSerialTv(1);
        // assert
        expect(provider.isAddedToWatchlist, true);
      });
      test('should execute save watchlist serial tv when function called',
          () async {
        // arrange
        when(mockSaveWatchlistSerialTv.execute(testSerialTvDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchListStatusSerialTv.execute(testSerialTvDetail.id))
            .thenAnswer((_) async => true);
        // act
        await provider.addWatchlistSerialTv(testSerialTvDetail);
        // assert
        verify(mockSaveWatchlistSerialTv.execute(testSerialTvDetail));
      });
      test(
          'should update watchlist serial tv status when add watchlist success',
          () async {
        // arrange
        when(mockSaveWatchlistSerialTv.execute(testSerialTvDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatusSerialTv.execute(testSerialTvDetail.id))
            .thenAnswer((_) async => true);
        // act
        await provider.addWatchlistSerialTv(testSerialTvDetail);
        // assert
        verify(mockGetWatchListStatusSerialTv.execute(testSerialTvDetail.id));
        expect(provider.isAddedToWatchlist, true);
        expect(provider.watchlistMessage, 'Added to Watchlist');
        expect(listenerCallCount, 1);
      });
      test(
          'should update watchlist serial tv message when add watchlist failed',
          () async {
        // arrange
        when(mockSaveWatchlistSerialTv.execute(testSerialTvDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatusSerialTv.execute(testSerialTvDetail.id))
            .thenAnswer((_) async => false);
        // act
        await provider.addWatchlistSerialTv(testSerialTvDetail);
        // assert
        expect(provider.watchlistMessage, 'Failed');
        expect(listenerCallCount, 1);
      });
    });
    group('on eror serial tv', () {
      test('should return error when data is unsuccessful', () async {
        // arrange
        when(mockGetSerialTvDetail.excute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetSerialTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tSerialTivi));
        // act
        await provider.fetchSerialTvDetail(tId);
        // assert
        expect(provider.serialTvState, RequestState.error);
        expect(provider.message, 'Server Failure');
        expect(listenerCallCount, 2);
      });
    });
  });
}
