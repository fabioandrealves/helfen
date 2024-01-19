import 'package:google_maps_flutter/google_maps_flutter.dart';

class StopBus {
  final int id;
  final int routeNumber;
  final LatLng stopBus;

  StopBus({
    required this.id,
    required this.routeNumber,
    required this.stopBus,
  });

  factory StopBus.fromData(Map<String, dynamic> data) {
    return StopBus(
      id: data['id'],
      routeNumber: data['route_number'],
      stopBus: LatLng(
        data['stop_latitude'],
        data['stop_longitude'],
      ),
    );
  }

  Map<String, dynamic> toData() {
    return {
      'id': id,
      'route_number': routeNumber,
      'stop_latitude': stopBus.latitude,
      'stop_longitude': stopBus.longitude,
    };
  }
}
