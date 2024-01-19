import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/infra/bus_stop.dart';

class BusRoute {
  final int routeNumber;
  final MapEntry<String, String> originInfo;
  final LatLng origin;
  final MapEntry<String, String> destinationInfo;
  final LatLng destination;
  final String direction;
  final List<StopBus> busStops;

  BusRoute({
    required this.routeNumber,
    required this.originInfo,
    required this.origin,
    required this.destinationInfo,
    required this.destination,
    required this.direction,
    required this.busStops,
  });

  factory BusRoute.fromData(Map<String, dynamic> data, List<StopBus> busStops) {
    return BusRoute(
      routeNumber: data['route_number'],
      originInfo: MapEntry<String, String>(
        data['origin_city'],
        data['origin_place'],
      ),
      origin: LatLng(
        data['origin_latitude'],
        data['origin_longitude'],
      ),
      destinationInfo: MapEntry<String, String>(
        data['destination_city'],
        data['destination_place'],
      ),
      destination: LatLng(
        data['destination_latitude'],
        data['destination_longitude'],
      ),
      direction: data['direction'],
      busStops: busStops,
    );
  }

  Map<String, dynamic> toData() {
    return {
      'route_number': routeNumber,
      'origin_city': originInfo.key,
      'origin_place': originInfo.value,
      'origin_latitude': origin.latitude,
      'origin_longitude': origin.longitude,
      'destination_city': destinationInfo.key,
      'destination_place': destinationInfo.value,
      'destination_latitude': destination.latitude,
      'destination_longitude': destination.longitude,
      'direction': direction,
      'bus_stops': busStops
          .map((stop) => {
                'stop_id': stop.id,
                'stop_latitude': stop.stopBus.latitude,
                'stop_longitude': stop.stopBus.longitude,
              })
          .toList(),
    };
  }
}
