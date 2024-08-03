import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_top_rated_serial_tv.dart';
import 'package:ditonton/presentation/provider_serial_tv/top_rated_serial_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'serial_tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedSerialTv])
void main() {
  late MockGetTopRatedSerialTv mockGetTopRatedSerialTv;
  late TopRatedSerialTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;

    mockGetTopRatedSerialTv = MockGetTopRatedSerialTv();
    notifier =
        TopRatedSerialTvNotifier(getTopRatedSerialTv: mockGetTopRatedSerialTv)
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
    when(mockGetTopRatedSerialTv.execute())
        .thenAnswer((_) async => Right(tSerialTvList));
    // act
    notifier.fetchTopRatedSerialTv();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });
  test('should change serial tv data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTopRatedSerialTv.execute())
        .thenAnswer((_) async => Right(tSerialTvList));
    // act
    await notifier.fetchTopRatedSerialTv();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.serialtv, tSerialTvList);
    expect(listenerCallCount, 2);
  });
  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedSerialTv.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedSerialTv();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
