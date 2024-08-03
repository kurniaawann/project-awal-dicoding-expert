import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usercases_serial_tv/remove_watchlist_serial_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data_serial_tv/dummy_objects_serialtv.dart';

import '../../helpers_serial_tv/test_helper_serial_tv.mocks.dart';

void main() {
  late RemoveWatchlistSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;
  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = RemoveWatchlistSerialTv(mockSerialTvRepository);
  });

  test('should remove watchlist Serial Tv from repository', () async {
    // arrange
    when(mockSerialTvRepository.removeWatchlistSerialTv(testSerialTvDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testSerialTvDetail);
    // assert
    verify(mockSerialTvRepository.removeWatchlistSerialTv(testSerialTvDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
