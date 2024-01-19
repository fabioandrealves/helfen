import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  late final LatLng latLng;

  Location({required this.latLng});

  Location.fromJson(Map<String, dynamic> json) {
    final double lat = json['lat'];
    final double lng = json['lng'];
    latLng = LatLng(lat, lng);
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': latLng.latitude,
      'lng': latLng.longitude,
    };
  }
}

// class Location {
//   late double lat;
//   late double lng;
//
//   Location({required this.lat, required this.lng});
//
//   Location.fromJson(Map<String, dynamic> json) {
//     lat = json['lat'];
//     lng = json['lng'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['lat'] = lat;
//     data['lng'] = lng;
//     return data;
//   }
// }
