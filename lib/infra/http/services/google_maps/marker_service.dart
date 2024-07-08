import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../model/google_maps/places/place.dart';

class MarkerService {
  LatLngBounds? bounds(Set<Marker> markers) {
    return markers.isEmpty
        ? null
        : createBounds(markers.map((m) => m.position).toList());
  }

  LatLngBounds createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value < element ? value : element); // smallest
    final southwestLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value > element ? value : element); // biggest
    final northeastLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon));
  }

  Marker createMarkerFromPlace(Place place, bool center) {
    var markerId = place.name;
    if (center) markerId = 'center';

    return Marker(
        markerId: MarkerId(markerId!),
        draggable: false,
        visible: (center) ? false : true,
        infoWindow: InfoWindow(title: place.name, snippet: place.vicinity),
        position: place.geometry!.location!.latLng);
  }
}

// markers: Set<Marker>.of(MarkerManager(
//   currentPosition: currentPosition,
//   origin: null,
//   destination: null,
// ).getMarkers()), // Marker(
