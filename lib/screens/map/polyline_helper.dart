import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../components/google_maps/route/polyline_points.dart';
import '../../components/google_maps/route/src/PointLatLng.dart';
import '../../components/google_maps/route/src/utils/polyline_result.dart';

class PolylineHelper {
  final PolylinePoints polylinePoints = PolylinePoints();

  Future<List<PointLatLng>> getPolylineCoordinates(
    LatLng origin,
    LatLng destination,
  ) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.status == 'OK') {
      return result.points;
    } else {
      return [];
    }
  }

  Polyline createPolyline(List<PointLatLng> points, int index) {
    return Polyline(
      polylineId: PolylineId('route_$index'),
      color: Colors.blue,
      width: 7,
      points: points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList(),
    );
  }
}
