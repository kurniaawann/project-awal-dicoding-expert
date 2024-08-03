import 'package:ditonton/data/models_serial_tv/serial_tv_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperSerialTv {
  static DatabaseHelperSerialTv? _databaseHelperSerialTv;

  DatabaseHelperSerialTv._instance() {
    _databaseHelperSerialTv = this;
  }

  factory DatabaseHelperSerialTv() =>
      _databaseHelperSerialTv ?? DatabaseHelperSerialTv._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlistSerialtv';

  Future<Database?> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/serial_tv_database.db';

    var db = await openDatabase(
      databasePath,
      version: 5,
      onCreate: _onCreate,
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tblWatchlist (
      id INTEGER PRIMARY KEY,
      name TEXT,
      overview TEXT,
      posterPath TEXT
    );
  ''');
  }

  Future<int> insertWatchlistSerialTv(SerialTvTable serialtv) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, serialtv.toJson());
  }

  Future<int> removeWatchlistSerialTv(SerialTvTable serialtv) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [serialtv.id],
    );
  }

  Future<Map<String, dynamic>?> getSerialTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistSerialTv() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
