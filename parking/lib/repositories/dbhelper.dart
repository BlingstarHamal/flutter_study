import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:parking/models/park.dart';

final String tableName = 'parks';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() {
    return _instance;
  }

  DBHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final database = openDatabase(join(await getDatabasesPath(), 'parks.db'),
        onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE $tableName(parking_code TEXT PRIMARY KEY, parking_name TEXT,lat REAL, lng REAL)",
      );
    }, version: 1);
    return database;
  }

  Future<void> insertPark(Park park) async {
    final db = await database;

    await db.insert(
      tableName,
      park.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Park> getPark(int parking_code) async {
    final db = await database;

    List<Map<String, dynamic>> maps = await db.query(tableName,
        columns: ['parking_code', 'parking_name', 'lat', 'lng'],
        where: 'Parking_code = ? ',
        whereArgs: [parking_code]);

    return Park.fromJoson(maps.first);
  }

  Future<List<Park>> parks() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('parks');

    return List.generate(maps.length, (i) {
      return Park(
        parking_code: maps[i]['parking_code'],
        parking_name: maps[i]['parking_name'],
        lat: maps[i]['lat'],
        lng: maps[i]['lng'],
      );
    });
  }

  Future<void> updatePark(Park park) async {
    final db = await database;

    await db.update(
      tableName,
      park.toJson(),
      where: 'parking_code = ?',
      whereArgs: [park.parking_code],
    );
  }

  Future<void> deletePark(int parkingCode) async {
    final db = await database;

    await db.delete(
      tableName,
      where: 'parking_code = ?',
      whereArgs: [parkingCode],
    );
  }

  Future<void> truncateParks() async {
    final db = await database;
    await db.rawDelete('DELETE FROM $tableName');
  }
}
