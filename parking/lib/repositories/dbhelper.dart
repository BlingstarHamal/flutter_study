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
    return _database!; }

    
  }
}
