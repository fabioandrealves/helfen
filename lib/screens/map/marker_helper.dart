import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerHelper {
  String getMarkerAsset({required int index, required int totalStops}) {
    if (index == 0) {
      return 'assets/images/inicio32.png';
    } else if (index == totalStops - 1) {
      return 'assets/images/fim32.png';
    } else {
      return 'assets/images/parada.png';
    }
  }

  Future<Marker> createMarker({
    required LatLng position,
    required String assetName,
    required String title,
  }) async {
    return Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      icon: await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)),
        assetName,
      ),
      infoWindow: InfoWindow(title: title),
    );
  }
}
