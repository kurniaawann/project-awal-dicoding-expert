import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/search_serial_tv.dart';
import 'package:ditonton/presentation/provider_serial_tv/serial_tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'serial_tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchSerialTv])
void main() {
  late SerialTvSearchNotifier provider;
  late MockSearchSerialTv mockSearchSerialTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchSerialTv = MockSearchSerialTv();
    provider = SerialTvSearchNotifier(searchSerialTv: mockSearchSerialTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tSerialTvModel = SerialTv(
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
  final tSerialTvList = <SerialTv>[tSerialTvModel];
  const tQuery = 'Tagesschau';

  group('search serial tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchSerialTv.execute(tQuery))
          .thenAnswer((_) async => Right(tSerialTvList));
      // act
      provider.fetchSerialTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchSerialTv.execute(tQuery))
          .thenAnswer((_) async => Right(tSerialTvList));
      // act
      await provider.fetchSerialTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.searchResultSerialTv, tSerialTvList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchSerialTv.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchSerialTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
