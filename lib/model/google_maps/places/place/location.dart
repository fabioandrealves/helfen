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
