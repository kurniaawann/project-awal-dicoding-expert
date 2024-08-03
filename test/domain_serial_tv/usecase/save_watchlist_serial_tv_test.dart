import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usercases_serial_tv/save_watchlist_serial_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data_serial_tv/dummy_objects_serialtv.dart';
import '../../helpers_serial_tv/test_helper_serial_tv.mocks.dart';

void main() {
  late SaveWatchlistSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = SaveWatchlistSerialTv(mockSerialTvRepository);
  });

  test('should save Serial Tv to the repository', () async {
    // arrange
    when(mockSerialTvRepository.saveWatchlistSerialTv(testSerialTvDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testSerialTvDetail);
    // assert
    verify(mockSerialTvRepository.saveWatchlistSerialTv(testSerialTvDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
