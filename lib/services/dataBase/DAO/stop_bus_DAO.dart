import 'package:sqflite/sqflite.dart';

import '../../../http/logger/custom_logger.dart';
import '../../../infra/bus_stop.dart';

class BusStopDAO {
  late final Future<Database> database;

  BusStopDAO(this.database);

  Future<void> insertStopBus(StopBus stopBus) async {
    final db = await database;
    try {
      await db.insert(
        'stop_bus',
        stopBus.toData(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      CustomLogger.logToLogcat(
          tag: "StopBusDAO",
          subTag: "insertStopBus",
          message: "Data's has been successfully inserted",
          logLevel: AndroidLogLevel.info);
    } catch (e) {
      CustomLogger.logToLogcat(
          tag: "BusRouteDAO",
          subTag: "insertStopBus",
          message: "Error inserting Bus Stop: $e",
          logLevel: AndroidLogLevel.error);
    }
  }

  Future<List<StopBus>> getAllStopBuses() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('stop_bus');
      return List.generate(maps.length, (i) {
        return StopBus.fromData(maps[i]);
      });
    } catch (e) {
      CustomLogger.logToLogcat(
          tag: "BusRouteDAO",
          subTag: "searchStopBus",
          message: "Error searching Bus Stop: $e",
          logLevel: AndroidLogLevel.error);
      return [];
    }
  }

  Future<void> updateStopBus(StopBus stopBus) async {
    final db = await database;
    try {
      await db.update(
        'stop_bus',
        stopBus.toData(),
        where: 'id = ?',
        whereArgs: [stopBus.id],
      );
      CustomLogger.logToLogcat(
          tag: "StopBusDAO",
          subTag: "updateStopBus",
          message: "Data's has been successfully updated: $stopBus",
          logLevel: AndroidLogLevel.info);
    } catch (e) {
      CustomLogger.logToLogcat(
          tag: "BusRouteDAO",
          subTag: "updateStopBus",
          message: "Error updating Bus Stop: $e",
          logLevel: AndroidLogLevel.error);
    }
  }

  Future<void> deleteStopBus(int id) async {
    final db = await database;
    try {
      await db.delete(
        'stop_bus',
        where: 'id = ?',
        whereArgs: [id],
      );
      CustomLogger.logToLogcat(
          tag: "StopBusDAO",
          subTag: "deleteStopBus",
          message: "Data's has been deleted successfully from id: $id",
          logLevel: AndroidLogLevel.info);
    } catch (e) {
      CustomLogger.logToLogcat(
          tag: "BusRouteDAO",
          subTag: "deleteStopBus",
          message: "Error deleting Bus Stop: $e",
          logLevel: AndroidLogLevel.error);
    }
  }
}
