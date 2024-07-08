import 'package:helfen_bus/infra/bus_route.dart';
import 'package:mysql1/mysql1.dart';

import '../dao.dart';
import '../db_configuration.dart';

class BusRouteDAO implements DAO<BusRouteModel> {
  DBConfiguration configuration;

  BusRouteDAO({required this.configuration});

  Future<Results> _executeQuery({
    required String sql,
    List<dynamic>? params,
  }) async {
    final connection = await configuration.connection;
    return await connection.query(sql, params);
  }

  @override
  Future<bool> create(BusRouteModel value) async {
    final result = await _executeQuery(
        sql: 'INSERT INTO bus_route('
            'route_number,'
            'origin_city,'
            'origin_place,'
            'destination_city,'
            'destination_place) '
            'VALUES (?, ?, ?, ?, ?)',
        params: [
          value.routeNumber,
          value.originInfo.key,
          value.originInfo.value,
          value.destinationInfo.key,
          value.destinationInfo.value,
        ]);
    return result.affectedRows! > 0;
  }

  @override
  Future<bool> delete(int routeNumber) async {
    final result = await _executeQuery(
        sql: 'DELETE FROM bus_route where route_number = ?',
        params: [routeNumber]);
    return result.affectedRows! > 0;
  }

  @override
  Future<List<BusRouteModel>> findAll() async {
    final result = await _executeQuery(sql: 'SELECT * FROM bus_route');
    return result
        .map((row) => BusRouteModel.fromData(row.fields))
        .toList()
        .cast<BusRouteModel>();
  }

  @override
  Future<BusRouteModel?> findOne(int routeNumber) async {
    final result = await _executeQuery(
        sql: 'SELECT * FROM bus_route where route_number = ?',
        params: [routeNumber]);
    return result.affectedRows == 0
        ? null
        : BusRouteModel.fromData(result.first.fields);
  }

  @override
  Future<bool> update(BusRouteModel value) async {
    final result = await _executeQuery(
      sql: 'UPDATE bus_route SET origin_city = ?, '
          'origin_place = ?, '
          'destination_city = ?, '
          'destination_place = ? '
          'WHERE route_number = ?',
      params: [
        value.originInfo.key,
        value.originInfo.value,
        value.destinationInfo.key,
        value.destinationInfo.value
      ],
    );
    return result.affectedRows! > 0;
  }
}

// find all

// final connection = await configuration.connection;
// final result = await connection.query('SELECT * FROM bus_route');
// List<BusRoute> busRoutes = [];
// for (ResultRow row in result) {
//   busRoutes.add(BusRoute.fromData(row.fields));
// }
// return busRoutes;
