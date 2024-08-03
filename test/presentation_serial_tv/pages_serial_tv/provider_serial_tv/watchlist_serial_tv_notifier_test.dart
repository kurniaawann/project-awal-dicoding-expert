import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_watchlist_serial_tv.dart';
import 'package:ditonton/presentation/provider_serial_tv/watchlist_serial_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data_serial_tv/dummy_objects_serialtv.dart';
import 'watchlist_serial_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistSerialTv])
void main() {
  late WatchlistSerialTvNotifier provider;
  late MockGetWatchlistSerialTv mockGetWatchlistSerialTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistSerialTv = MockGetWatchlistSerialTv();
    provider = WatchlistSerialTvNotifier(
        getWatchlistSerialTv: mockGetWatchlistSerialTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change serial tv data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetWatchlistSerialTv.execute())
        .thenAnswer((_) async => const Right([testWatchlistSerialTv]));
    // act
    await provider.fetchWatchlistSerialTv();
    // assert
    expect(provider.watchlistState, RequestState.loaded);
    expect(provider.watchlistSerialTv, [testWatchlistSerialTv]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistSerialTv.execute())
        .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistSerialTv();
    // assert
    expect(provider.watchlistState, RequestState.error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
