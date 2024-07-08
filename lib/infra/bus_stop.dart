import 'package:google_maps_flutter/google_maps_flutter.dart';

class StopBusModel {
  final int? id;
  final int routeNumber;
  final LatLng stopBus;
  final bool isOutbound;

  StopBusModel({
    required this.id,
    required this.routeNumber,
    required this.stopBus,
    required this.isOutbound,
  });

  factory StopBusModel.fromData(Map<String, dynamic> data) {
    return StopBusModel(
        id: data['id'].toInt(),
        routeNumber: data['route_number'].toInt(),
        stopBus: LatLng(
          data['stop_latitude'].toDouble(),
          data['stop_longitude'].toDouble(),
        ),
        isOutbound: data['is_outbound'] == 1);
  }

  Map<String, dynamic> toData() {
    return {
      'id': id,
      'route_number': routeNumber,
      'stop_latitude': stopBus.latitude,
      'stop_longitude': stopBus.longitude,
      'is_outbound': isOutbound
    };
  }

  @override
  String toString() {
    return '\n\tStopBus\n'
        '\t\t{\n'
        '\t\t\tid: $id,\n'
        '\t\t\trouteNumber: $routeNumber,\n'
        '\t\t\tstop_latitude: ${stopBus.latitude},\n'
        '\t\t\tstop_longitude: ${stopBus.longitude},\n'
        '\t\t\tis_outbound: $isOutbound\n'
        '\t\t}\n';
  }
}
