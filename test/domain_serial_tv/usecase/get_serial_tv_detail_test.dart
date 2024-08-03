import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_serial_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data_serial_tv/dummy_objects_serialtv.dart';
import '../../helpers_serial_tv/test_helper_serial_tv.mocks.dart';

void main() {
  late GetSerialTvDetail usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = GetSerialTvDetail(mockSerialTvRepository);
  });

  const tId = 1;

  test('should get serialtv detail from the repository', () async {
    // arrange
    when(mockSerialTvRepository.getSerialTvDetail(tId))
        .thenAnswer((_) async => const Right(testSerialTvDetail));
    // act
    final result = await usecase.excute(tId);
    // assert
    expect(result, const Right(testSerialTvDetail));
  });
}
