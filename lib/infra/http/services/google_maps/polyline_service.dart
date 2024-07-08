import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

import '../../../../components/google_maps/route/src/PointLatLng.dart';
import '../../../../components/google_maps/route/src/utils/polyline_result.dart';
import '../../../../components/google_maps/route/src/utils/polyline_waypoint.dart';
import '../../../../components/google_maps/route/src/utils/request_enums.dart';
import '../../../../mapS.dart';
import '../../../logger/http_Interceptors.dart';

class RouteService {
  static const String STATUS_OK = "ok";

  http.Client client = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
    ],
  );

  Future<PolylineResult> getRouteBetweenCoordinates(
    PointLatLng origin,
    PointLatLng destination,
    TravelMode travelMode,
    List<PolylineWayPoint> wayPoints,
    bool avoidHighways,
    bool avoidTolls,
    bool avoidFerries,
    bool optimizeWaypoints,
  ) async {
    final mode = travelMode.toString().replaceAll('TravelMode.', '');
    final result = PolylineResult();

    final params = {
      "origin": "${origin.latitude},${origin.longitude}",
      "destination": "${destination.latitude},${destination.longitude}",
      "mode": mode,
      "avoidHighways": "$avoidHighways",
      "avoidFerries": "$avoidFerries",
      "avoidTolls": "$avoidTolls",
      "key": Maps.apiKey,
    };

    if (wayPoints.isNotEmpty) {
      final wayPointsArray = wayPoints.map((point) => point.location).toList();
      var wayPointsString = wayPointsArray.join('|');
      if (optimizeWaypoints) {
        wayPointsString = 'optimize:true|$wayPointsString';
      }
      params.addAll({"waypoints": wayPointsString});
    }
    Uri uri =
        Uri.https("maps.googleapis.com", "maps/api/directions/json", params);

    final response = await client.get(uri);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body);
      result.status = json["status"];
      if (json["status"]?.toLowerCase() == STATUS_OK &&
          json["routes"] != null &&
          json["routes"].isNotEmpty) {
        result.points = decodeEncodedPolyline(
            json["routes"][0]["overview_polyline"]["points"]);
      } else {
        result.errorMessage = json["error_message"];
      }
    }
    return result;
  }

  List<PointLatLng> decodeEncodedPolyline(String encoded) {
    List<PointLatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      PointLatLng p =
          PointLatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }
}
