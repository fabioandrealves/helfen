import 'package:helfen_bus/http/logger/custom_logger.dart';
import 'package:helfen_bus/infra/bus_route.dart';
import 'package:sqflite/sqflite.dart';

class BusRouteDAO {
  final Database database;

  BusRouteDAO(this.database);

  Future<void> insertBusRoute(BusRoute busRoute) async {
    final db = database;
    try {
      await db.insert(
        'bus_route',
        busRoute.toData(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      CustomLogger.logToLogcat(
          tag: "BusRouteDAO",
          subTag: "insertBusRoute",
          message: "Data's added!",
          logLevel: AndroidLogLevel.info);
    } catch (e) {
      CustomLogger.logToLogcat(
          tag: "BusRouteDAO",
          subTag: "insertBusRoute",
          message: "Error adding data's: $e",
          logLevel: AndroidLogLevel.error);
    }
  }

  Future<void> updateBusRoute(BusRoute busRoute) async {
    final db = database;
    try {
      await db.update(
        'bus_route',
        busRoute.toData(),
        where: 'route_number = ?',
        whereArgs: [busRoute.routeNumber],
      );
      CustomLogger.logToLogcat(
          tag: "BusRouteDAO",
          subTag: "updateBusRoute",
          message: "Updated Bus Route!",
          logLevel: AndroidLogLevel.warning);
    } catch (e) {
      CustomLogger.logToLogcat(
          tag: "BusRouteDAO",
          subTag: "updateBusRoute",
          message: "Error Updating Bus Route: $e",
          logLevel: AndroidLogLevel.error);
    }
  }

  Future<void> deleteBusRoute(int routeNumber) async {
    final db = database;
    try {
      await db.delete(
        'bus_route',
        where: 'route_number = ?',
        whereArgs: [routeNumber],
      );
      CustomLogger.logToLogcat(
          tag: "BusRouteDAO",
          subTag: "deleteBusRoute",
          message: "Deleted Bus Route!",
          logLevel: AndroidLogLevel.warning);
    } catch (e) {
      CustomLogger.logToLogcat(
          tag: "BusRouteDAO",
          subTag: "deleteBusRoute",
          message: "Error deleting Bus Route: $e",
          logLevel: AndroidLogLevel.error);
    }
  }
}

// Future<List<BusRoute>> searchBusRoutes(String searchText) async {
//   final db = database;
//   try {
//     final List<Map<String, dynamic>> data = await db.query(
//       'bus_route',
//       where:
//           'route_number = ? OR origin_city LIKE ? OR destination_city LIKE ?',
//       whereArgs: [int.tryParse(searchText), '%$searchText%', '%$searchText%'],
//     );
//     return List.generate(data.length, (i) {
//       return BusRoute.fromData(data[i], []);
//     });
//   } catch (e) {
//     logger.e('Erro ao buscar dados da tabela bus_route: $e');
//     return [];
//   }
}
