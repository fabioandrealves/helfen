import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../http/logger/custom_logger.dart';

class DataBaseHelper {
  static final DataBaseHelper _instance = DataBaseHelper._internal();

  factory DataBaseHelper() => _instance;

  DataBaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'places_database.db');
    CustomLogger.logWarning("DataBase path: $path");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    try {
      await db.execute('''
    CREATE TABLE IF NOT EXISTS bus_route (
      route_number INTEGER PRIMARY KEY NOT NULL,
      origin_city TEXT NOT NULL,
      origin_place TEXT NOT NULL,
      origin_latitude REAL NOT NULL,
      origin_longitude REAL NOT NULL,
      destination_city TEXT NOT NULL,
      destination_place TEXT NOT NULL,
      destination_latitude REAL NOT NULL,
      destination_longitude REAL NOT NULL,
      direction TEXT NOT NULL
      )
    ''');

      await db.execute('''
    CREATE TABLE IF NOT EXISTS bus_stops (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      route_number INTEGER NOT NULL,
      stop_latitude REAL NOT NULL,
      stop_longitude REAL NOT NULL,
      FOREIGN KEY (route_number) REFERENCES bus_route (route_number)
      )
    ''');
      CustomLogger.logToLogcat(
        tag: "DataBaseHelper",
        subTag: "createTables",
        message: "Tables created!",
        logLevel: AndroidLogLevel.info,
      );
    } catch (e) {
      CustomLogger.logToLogcat(
        tag: "DataBaseHelper",
        subTag: "createTables",
        message: "Error creating tables: $e",
        logLevel: AndroidLogLevel.error,
      );
    }
  }

  Future<void> deleteTables() async {
    try {
      Database db = await database;

      await db.transaction((txn) async {
        await txn.execute('DROP TABLE IF EXISTS bus_route');
        await txn.execute('DROP TABLE IF EXISTS bus_stops');
      });
      // CustomLogger.logInfo("Deleted!!!");
      CustomLogger.logToLogcat(
        tag: "DataBaseHelper",
        subTag: "delete tables",
        message: "Tables deleted!",
        logLevel: AndroidLogLevel.info,
      );
    } catch (e) {
      CustomLogger.logToLogcat(
        tag: "DataBaseHelper",
        subTag: "delete tables",
        message: "Erro ao excluir tabelas: $e",
        logLevel: AndroidLogLevel.error,
      );
    }
  }
}
