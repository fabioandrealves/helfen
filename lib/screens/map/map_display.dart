import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/Widgets/markers.dart';
import 'package:helfen_bus/blocs/maps_location_bloc.dart';

class MapDisplay extends StatefulWidget {
  final MapsLocationController mapLocationController;
  final LatLng destination;

  const MapDisplay({
    super.key,
    required this.destination,
    required this.mapLocationController,
  });

  @override
  _MapDisplayState createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  final Completer<GoogleMapController> _mapController = Completer();
  late final Markers markers = Markers(
      currentPosition: widget.mapLocationController.currentLocation!,
      destination: widget.destination);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Localização'),
      ),
      body: (widget.mapLocationController.currentLocation == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              mapType: MapType.normal,
              onMapCreated: (controller) => _mapController.complete(controller),
              initialCameraPosition: CameraPosition(
                target: widget.destination,
                zoom: 15.0,
              ),
              markers: markers.getMarkers(),
            ),
    );
  }
}
