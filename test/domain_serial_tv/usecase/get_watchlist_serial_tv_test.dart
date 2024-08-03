import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_watchlist_serial_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data_serial_tv/dummy_objects_serialtv.dart';
import '../../helpers_serial_tv/test_helper_serial_tv.mocks.dart';

void main() {
  late GetWatchlistSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;
  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = GetWatchlistSerialTv(mockSerialTvRepository);
  });

  test('should get list of Serial tv from the repository', () async {
    // arrange
    when(mockSerialTvRepository.getWatchlistSerialTv())
        .thenAnswer((_) async => Right(testSerialTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testSerialTvList));
  });
}
