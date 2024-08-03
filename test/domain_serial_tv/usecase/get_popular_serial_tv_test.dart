import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/get_popular_serial_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers_serial_tv/test_helper_serial_tv.mocks.dart';

void main() {
  late GetPopularSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = GetPopularSerialTv(mockSerialTvRepository);
  });

  final tSerialTv = <SerialTv>[];

  group('Get Popular Serial tv test', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockSerialTvRepository.getPopularSerialTv())
            .thenAnswer((_) async => Right(tSerialTv));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tSerialTv));
      });
    });
  });
}
