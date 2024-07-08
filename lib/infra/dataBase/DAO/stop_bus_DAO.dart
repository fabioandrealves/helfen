import 'package:helfen_bus/infra/bus_stop.dart';
import 'package:mysql1/mysql1.dart';

import '../../logger/custom_logger.dart';
import '../dao.dart';
import '../db_configuration.dart';

class StopBusDAO implements DAO<StopBusModel> {
  DBConfiguration configuration;

  StopBusDAO({required this.configuration});

  Future<Results> _executeQuery({
    required String sql,
    List<dynamic>? params,
  }) async {
    final connection = await configuration.connection;
    return await connection.query(sql, params);
  }

  @override
  Future<bool> create(StopBusModel value) async {
    final result = await _executeQuery(
      sql: 'INSERT INTO bus_stops ('
          'id,'
          'route_number,'
          'stop_latitude,'
          'stop_longitude,'
          'is_outbound)'
          'VALUES (? , ?, ?, ?, ?)',
      params: [
        value.id,
        value.routeNumber,
        value.stopBus.latitude,
        value.stopBus.longitude,
        value.isOutbound
      ],
    );
    return result.affectedRows! > 0;
  }

  @override
  Future<bool> delete(int id) async {
    final result = await _executeQuery(
        sql: 'DELETE FROM bus_stops where id = ?', params: [id]);
    return result.affectedRows! > 0;
  }

  @override
  Future<List<StopBusModel>> findAll() async {
    try {
      final result = await _executeQuery(sql: 'SELECT * FROM bus_stops');
      for (ResultRow r in result) {
        StopBusModel stopBus = StopBusModel.fromData(r.fields);
        CustomLogger.logToLogcat(
            tag: 'findAll',
            subTag: 'StopBusModel',
            message: stopBus.toString(),
            logLevel: AndroidLogLevel.info);
      }
      return result
          .map((row) => StopBusModel.fromData(row.fields))
          .toList()
          .cast<StopBusModel>();
    } catch (e) {
      CustomLogger.logToLogcat(
          tag: 'findAll',
          subTag: "StopBusModel",
          message: "Error searching results: $e",
          logLevel: AndroidLogLevel.error);
      return [];
    }
  }

  @override
  Future<StopBusModel?> findOne(int id) async {
    final result = await _executeQuery(
        sql: 'SELECT * FROM bus_stops where id = ?', params: [id]);
    return result.affectedRows == 0
        ? null
        : StopBusModel.fromData(result.first.fields);
  }

  @override
  Future<bool> update(StopBusModel value) async {
    final result = await _executeQuery(
      sql: 'UPDATE bus_stops SET '
          'route_number = ?, '
          'stop_latitude = ?, '
          'stop_longitude = ?, '
          'is_outbound = ? '
          'WHERE id = ?',
      params: [
        value.routeNumber,
        value.stopBus.latitude,
        value.stopBus.longitude,
        value.isOutbound,
        value.id,
      ],
    );
    return result.affectedRows! > 0;
  }
}

// class BusStopDAO {
//   late final Database database;
//
//   BusStopDAO(this.database);
//
//   Future<void> insertStopBus(StopBus stopBus) async {
//     final db = database;
//     try {
//       await db.insert(
//         'stop_bus',
//         stopBus.toData(),
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//       CustomLogger.logToLogcat(
//           tag: "StopBusDAO",
//           subTag: "insertStopBus",
//           message: "Data's has been successfully inserted",
//           logLevel: AndroidLogLevel.info);
//     } catch (e) {
//       CustomLogger.logToLogcat(
//           tag: "BusRouteDAO",
//           subTag: "insertStopBus",
//           message: "Error inserting Bus Stop: $e",
//           logLevel: AndroidLogLevel.error);
//     }
//   }
//
//   Future<Map<String, dynamic>> getAllStopBuses(
//       {required int routeNumber}) async {
//     final db = database;
//     try {
//       final List<Map<String, dynamic>> stopMaps = await db.query(
//         'bus_stops',
//         where: 'route_number = ?',
//         whereArgs: [routeNumber],
//       );
//
//       return {'stops': stopMaps};
//     } catch (e) {
//       CustomLogger.logToLogcat(
//           tag: "BusStopDAO",
//           subTag: "getAllStopBuses",
//           message: "Error getting Bus Stops: $e",
//           logLevel: AndroidLogLevel.error);
//       return {'error': e.toString()};
//     }
//   }
//
//   Future<void> updateStopBus(StopBus stopBus) async {
//     final db = database;
//     try {
//       await db.update(
//         'stop_bus',
//         stopBus.toData(),
//         where: 'id = ?',
//         whereArgs: [stopBus.stopBus],
//       );
//       CustomLogger.logToLogcat(
//           tag: "StopBusDAO",
//           subTag: "updateStopBus",
//           message: "Data's has been successfully updated: $stopBus",
//           logLevel: AndroidLogLevel.info);
//     } catch (e) {
//       CustomLogger.logToLogcat(
//           tag: "BusRouteDAO",
//           subTag: "updateStopBus",
//           message: "Error updating Bus Stop: $e",
//           logLevel: AndroidLogLevel.error);
//     }
//   }
//
//   Future<void> deleteStopBus(int id) async {
//     final db = database;
//     try {
//       await db.delete(
//         'stop_bus',
//         where: 'id = ?',
//         whereArgs: [id],
//       );
//       CustomLogger.logToLogcat(
//           tag: "StopBusDAO",
//           subTag: "deleteStopBus",
//           message: "Data's has been deleted successfully from id: $id",
//           logLevel: AndroidLogLevel.info);
//     } catch (e) {
//       CustomLogger.logToLogcat(
//           tag: "BusRouteDAO",
//           subTag: "deleteStopBus",
//           message: "Error deleting Bus Stop: $e",
//           logLevel: AndroidLogLevel.error);
//     }
//   }
// }
