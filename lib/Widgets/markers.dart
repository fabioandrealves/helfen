import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Markers {
  final Position currentPosition;
  final LatLng destination;

  const Markers({required this.currentPosition, required this.destination});

  Set<Marker> getMarkers() => _getMarkers();

  Set<Marker> _getMarkers() {
    return {
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(
          currentPosition.latitude,
          currentPosition.longitude,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue,
        ),
        infoWindow: const InfoWindow(title: 'Localização Atual'),
      ),
      Marker(
        markerId: const MarkerId("destination"),
        position: destination,
        infoWindow: const InfoWindow(title: "Destino"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };
  }
}
