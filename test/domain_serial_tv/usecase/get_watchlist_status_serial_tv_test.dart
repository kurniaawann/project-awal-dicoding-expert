import 'package:mockito/mockito.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_watchlist_status_serial_tv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers_serial_tv/test_helper_serial_tv.mocks.dart';

void main() {
  late GetWatchListStatusSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = GetWatchListStatusSerialTv(mockSerialTvRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockSerialTvRepository.isAddedToWatchlistSerialTv(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
