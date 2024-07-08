import 'package:helfen_bus/components/google_maps/route/src/PointLatLng.dart';
import 'package:helfen_bus/components/google_maps/route/src/utils/polyline_result.dart';
import 'package:helfen_bus/components/google_maps/route/src/utils/polyline_waypoint.dart';
import 'package:helfen_bus/components/google_maps/route/src/utils/request_enums.dart';

class PolylinePoints {
  RouteService route = RouteService();

  Future<PolylineResult> getRouteBetweenCoordinates(
      PointLatLng origin, PointLatLng destination,
      {TravelMode travelMode = TravelMode.driving,
      List<PolylineWayPoint> wayPoints = const [],
      bool avoidHighways = false,
      bool avoidTolls = false,
      bool avoidFerries = true,
      bool optimizeWaypoints = false}) async {
    return await route.getRouteBetweenCoordinates(
        origin,
        destination,
        travelMode,
        wayPoints,
        avoidHighways,
        avoidTolls,
        avoidFerries,
        optimizeWaypoints);
  }

  List<PointLatLng> decodePolyline(String encodedString) {
    return route.decodeEncodedPolyline(encodedString);
  }
}
