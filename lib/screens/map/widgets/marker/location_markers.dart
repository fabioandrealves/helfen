import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMarker {
  final Position? currentLocation;
  final LatLng destination;

  LocationMarker({required this.currentLocation, required this.destination});

  Marker _createMarker({
    required LatLng position,
    required double hue,
    required String title,
  }) {
    return Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(hue),
      infoWindow: InfoWindow(title: title),
    );
  }

  Future<List<Marker>> buildMarkers() async {
    final List<Marker> markers = [];

    markers.add(_createMarker(
        position: LatLng(currentLocation!.latitude, currentLocation!.longitude),
        hue: BitmapDescriptor.hueBlue,
        title: 'Localização atual'));

    markers.add(_createMarker(
        position: destination,
        hue: BitmapDescriptor.hueRose,
        title: 'Destino'));

    return markers;
  }
}
