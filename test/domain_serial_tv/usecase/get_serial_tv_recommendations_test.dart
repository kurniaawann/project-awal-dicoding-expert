import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_recommendations_serial_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers_serial_tv/test_helper_serial_tv.mocks.dart';

void main() {
  late GetSerialTvRecommendations usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = GetSerialTvRecommendations(mockSerialTvRepository);
  });

  const tId = 1;
  final tSerialTv = <SerialTv>[];

  test('should get list of Serial tv recommendations from the repository',
      () async {
    // arrange
    when(mockSerialTvRepository.getSerialTvRecommendations(tId))
        .thenAnswer((_) async => Right(tSerialTv));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tSerialTv));
  });
}
