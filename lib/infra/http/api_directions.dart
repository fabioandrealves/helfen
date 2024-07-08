// import 'dart:convert';
// import 'package:flutter_polyline_points/polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:helfen/Screen/map/mapS.dart';
// import 'package:http/http.dart' as http;
//
// class ApiDirections {
//   Future<List<LatLng>> getPolyline(LatLng destination) async {
//     LatLng origin = await MapConstants.getCurrentLocation();
//
//     String url =
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=${MapConstants.apiKey}';
//
//     http.Response response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       List<PointLatLng> result = PolylinePoints()
//           .decodePolyline(data['routes'][0]['overview_polyline']['points']);
//       List<LatLng> polylineCoordinates = [];
//       if (result.isNotEmpty) {
//         for (var point in result) {
//           polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//         }
//       }
//       return polylineCoordinates;
//     } else {
//       throw Exception('Failed to fetch polyline');
//     }
//   }
// }
