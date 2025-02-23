import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/screens/map/marker/marker_helper.dart';

class LocationMarker {
  final Position? currentLocation;
  final LatLng destination;
  final MarkerHelper markerHelper = MarkerHelper();

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
    final busMarker = await markerHelper.createMarker(
        position: const LatLng(-22.7266749, -47.3761782),
        assetName: 'assets/images/bus_backward2x.png',
        title: "ônibus");

    markers.add(_createMarker(
        position: LatLng(currentLocation!.latitude, currentLocation!.longitude),
        hue: BitmapDescriptor.hueBlue,
        title: 'Localização atual'));

    markers.add(_createMarker(
        position: destination,
        hue: BitmapDescriptor.hueRose,
        title: 'Destino'));

    markers.add(busMarker);

    return markers;
  }
}
