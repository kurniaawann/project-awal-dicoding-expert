import 'package:ditonton/common/exception.dart';

import 'package:ditonton/data/datasources_serial_tv/db_serial_tv/database_helper_serial_tv.dart';

import 'package:ditonton/data/models_serial_tv/serial_tv_table.dart';

abstract class SerialTvDataSource {
  Future<String> insertWatchlistSerialTv(SerialTvTable serialTvTable);
  Future<String> removeWatchlistSerialTv(SerialTvTable serialTvTable);
  Future<SerialTvTable?> getSerialTvById(int id);
  Future<List<SerialTvTable>> getWatchlistSerialTv();
}

class SerialTvLocalDataSourceImpl implements SerialTvDataSource {
  final DatabaseHelperSerialTv databaseHelperST;

  SerialTvLocalDataSourceImpl({required this.databaseHelperST});

  @override
  Future<String> insertWatchlistSerialTv(SerialTvTable serialTvTable) async {
    try {
      await databaseHelperST.insertWatchlistSerialTv(serialTvTable);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistSerialTv(SerialTvTable serialTvTable) async {
    try {
      await databaseHelperST.removeWatchlistSerialTv(serialTvTable);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<SerialTvTable?> getSerialTvById(int id) async {
    final result = await databaseHelperST.getSerialTvById(id);
    if (result != null) {
      return SerialTvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<SerialTvTable>> getWatchlistSerialTv() async {
    final result = await databaseHelperST.getWatchlistSerialTv();
    return result.map((data) => SerialTvTable.fromMap(data)).toList();
  }
}
