import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_serial_tv.dart';
import 'package:ditonton/presentation/provider_serial_tv/now_playing_serial_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_serial_tv_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingSerialTv])
void main() {
  late MockGetNowPlayingSerialTv mockGetNowPlayingSerialTv;
  late NowPlayingSerialTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 2;
    mockGetNowPlayingSerialTv = MockGetNowPlayingSerialTv();
    notifier = NowPlayingSerialTvNotifier(
        getNowPlayingSerialTv: mockGetNowPlayingSerialTv)
      ..addListener(() {
        listenerCallCount++;
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingSerialTv.execute())
        .thenAnswer((_) async => Right(tSerialTvList));
    // act
    notifier.fetchNowPlayingSerialTv();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 3);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingSerialTv.execute())
        .thenAnswer((_) async => Right(tSerialTvList));
    // act
    await notifier.fetchNowPlayingSerialTv();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.serialtv, tSerialTvList);
    expect(listenerCallCount, 4);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingSerialTv.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchNowPlayingSerialTv();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 4);
  });
}
