import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities_serial_tv/serial_tv.dart';
import 'package:ditonton/domain/usercases_serial_tv/search_serial_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers_serial_tv/test_helper_serial_tv.mocks.dart';

void main() {
  late SearchSerialTv usecase;
  late MockSerialTvRepository mockSerialTvRepository;

  setUp(() {
    mockSerialTvRepository = MockSerialTvRepository();
    usecase = SearchSerialTv(mockSerialTvRepository);
  });

  final tSerialTv = <SerialTv>[];
  const tQuery = 'Tagesschau';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockSerialTvRepository.searchSerialTv(tQuery))
        .thenAnswer((_) async => Right(tSerialTv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSerialTv));
  });
}
