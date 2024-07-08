import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/screens/map/widgets/marker/location_markers.dart';

import '../../blocs/route/route_bloc.dart';
import '../../blocs/route/route_state.dart';

class MapView extends StatefulWidget {
  final Position currentLocation;
  final LatLng destination;

  const MapView({
    Key? key,
    required this.currentLocation,
    required this.destination,
  }) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _completer = Completer();
  late GoogleMapController _googleMapController;
  late LocationMarker _location;
  List<Marker> _markers = [];
  List<Polyline> _polylines = [];

  @override
  void initState() {
    super.initState();
    _initializeLocationMarker();
  }

  void _initializeLocationMarker() {
    _location = LocationMarker(
      currentLocation: widget.currentLocation,
      destination: widget.destination,
    );
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  Future<void> _updateMarkersAndPolylines(RouteLoaded state) async {
    List<Marker> locationMarkers = await _location.buildMarkers();
    setState(() {
      _markers = [
        ...locationMarkers,
        ...state.route.map((entry) => entry.key).toList(),
      ];
      _polylines = state.route.map((entry) => entry.value).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouteBloc, RouteState>(
      builder: (context, state) {
        if (state is RouteLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RouteLoaded) {
          _updateMarkersAndPolylines(state);
        } else if (state is RouteError) {
          return const Center(child: Text('Erro ao carregar marcadores'));
        }

        return GoogleMap(
          mapType: MapType.normal,
          onMapCreated: (controller) {
            _googleMapController = controller;
            _completer.complete(_googleMapController);
          },
          initialCameraPosition: CameraPosition(
            target: widget.destination,
            zoom: 15.0,
          ),
          markers: _markers.toSet(),
          polylines: _polylines.toSet(),
        );
      },
    );
  }
}

// class MapScreen extends StatefulWidget {
//   final LatLng destination;
//   final Position currentLocation;
//   const MapScreen(
//       {super.key, required this.destination, required this.currentLocation});
//
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   final Completer<GoogleMapController> _completer = Completer();
//   late GoogleMapController _googleMapController;
//   late List<MapEntry<Marker, Polyline>> _markerPolylineEntries = [];
//   late List<Marker>? _markers = [];
//   late List<Polyline> _polylines = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadMarkers();
//   }
//
//   Future<void> _loadMarkers() async {
//     StopBusDAO stopBusDAO = StopBusDAO(configuration: Maps.configuration);
//     LocationMarker location = LocationMarker(
//         currentLocation: widget.currentLocation,
//         destination: widget.destination);
//     BusStopMarker busStops = BusStopMarker(
//         stopBusDAO: stopBusDAO,
//         currentLocation: widget.currentLocation,
//         destination: widget.destination);
//
//     List<Marker> locationMarkers = await location.buildMarkers();
//     List<MapEntry<Marker, Polyline>> stopMarkers =
//         await busStops.buildMarkers();
//
//     setState(() {
//       _markers = [
//         ...locationMarkers,
//         ...stopMarkers.map((entry) => entry.key).toList(),
//       ];
//       _polylines = stopMarkers.map((entry) => entry.value).toList();
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _googleMapController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       mapType: MapType.normal,
//       onMapCreated: (controller) {
//         _googleMapController = controller;
//         _completer.complete(_googleMapController);
//       },
//       initialCameraPosition: CameraPosition(
//         target: widget.destination,
//         zoom: 15.0,
//       ),
//       markers: _markers!.toSet(),
//       polylines: _polylines.toSet(),
//     );
//   }
// }
