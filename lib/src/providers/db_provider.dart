import 'dart:io';
import 'package:examen2p_ruilova/src/model/travel_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    final path = join(appDir.path, 'travels.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
    onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE travel(
        id INTEGER PRIMARY KEY,
        origen TEXT,
        destino TEXT,
        recorrido TEXT,
        fecha DATETIME
      )
       ''');
    });
    }

    Future<int> insert(Travel newElement) async {
      final db = await database;
      final newId = await db.insert('travel', newElement.toJson());
      return newId;
    }

    Future<dynamic> list() async {
      final db = await database;
      final result = await db.query('travel');
      return result.isNotEmpty ? result.map((t) => Travel.fromJson(t)).toList() : [];
    }

}