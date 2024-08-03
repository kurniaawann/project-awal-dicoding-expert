import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources_serial_tv/serial_tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data_serial_tv/dummy_objects_serialtv.dart';

import '../../helpers_serial_tv/test_helper_serial_tv.mocks.dart';

void main() {
  late SerialTvLocalDataSourceImpl dataSourceImpl;
  late MockDatabaseHelperSerialTv mockDatabaseHelperSerialTv;

  setUp(() {
    mockDatabaseHelperSerialTv = MockDatabaseHelperSerialTv();
    dataSourceImpl = SerialTvLocalDataSourceImpl(
        databaseHelperST: mockDatabaseHelperSerialTv);
  });

  group('save watchlist serial tv', () {
    test('should return success message when insert to database is success',
        () async {
      //arrange
      when(mockDatabaseHelperSerialTv
              .insertWatchlistSerialTv(testSerialTvTable))
          .thenAnswer((_) async => 1);

      //act
      final result =
          await dataSourceImpl.insertWatchlistSerialTv(testSerialTvTable);

      //assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () {
      //arrange
      when(mockDatabaseHelperSerialTv
              .insertWatchlistSerialTv(testSerialTvTable))
          .thenThrow(Exception());
      //act
      final call = dataSourceImpl.insertWatchlistSerialTv(testSerialTvTable);
      //assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist serial tv', () {
    test('should return success message when remove from database is success',
        () async {
      //arrange
      when(mockDatabaseHelperSerialTv
              .removeWatchlistSerialTv(testSerialTvTable))
          .thenAnswer((_) async => 1);

      //act
      final result =
          await dataSourceImpl.removeWatchlistSerialTv(testSerialTvTable);
      //assert
      expect(result, 'Removed from Watchlist');
    });
    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperSerialTv
              .removeWatchlistSerialTv(testSerialTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSourceImpl.removeWatchlistSerialTv(testSerialTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Serial Tv Detail By Id', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperSerialTv.getSerialTvById(tId))
          .thenAnswer((_) async => testSerialTvMap);
      // act
      final result = await dataSourceImpl.getSerialTvById(tId);
      // assert
      expect(result, testSerialTvTable);
    });
    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperSerialTv.getSerialTvById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSourceImpl.getSerialTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelperSerialTv.getWatchlistSerialTv())
          .thenAnswer((_) async => [testSerialTvMap]);
      // act
      final result = await dataSourceImpl.getWatchlistSerialTv();
      // assert
      expect(result, [testSerialTvTable]);
    });
  });
}
