import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/infra/logger/custom_logger.dart';
import 'package:helfen_bus/screens/map/widgets/marker/location_markers.dart';

import '../../blocs/route/route_bloc.dart';
import '../../blocs/route/route_state.dart';
import '../../cubit/nearest_stop_cubit.dart';
import '../../infra/bus_stop.dart';
import '../../infra/http/mapS.dart';

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
  StopBusModel? _nearestStop;
  Marker? _busMarker;

  double get _calculateDistanceByBusToNearestStop => Geolocator.distanceBetween(
        _busMarker!.position.latitude,
        _busMarker!.position.longitude,
        _nearestStop!.stopBus.latitude,
        _nearestStop!.stopBus.longitude,
      );

  String get formattedDistance => (_calculateDistanceByBusToNearestStop <= 1000)
      ? "${_calculateDistanceByBusToNearestStop.toStringAsFixed(0)} metros"
      : "${(_calculateDistanceByBusToNearestStop / 1000).toStringAsFixed(1)} km";

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

    Marker? newBusMarker = locationMarkers.firstWhere(
      (marker) => marker.infoWindow.title == "ônibus",
      orElse: () => const Marker(markerId: MarkerId("busMarkerNull")),
    );

    setState(() {
      _markers = [
        ...state.route.map((entry) => entry.key).toList(),
        ...locationMarkers,
      ];
      _polylines = state.route.map((entry) => entry.value).toList();
      _busMarker = (newBusMarker.markerId.value == "busMarkerNull")
          ? null
          : newBusMarker;
    });

    if (_busMarker != null) {
      CustomLogger.logInfo(
          "🚌 Marcador do ônibus atualizado: ${_busMarker!.position}");
    } else {
      Maps.speakText.speak("Não foi possível encontrar um ônibus em trajeto.");
    }

    _speakDistanceToBus();
  }

  void _speakDistanceToBus() {
    Maps.speakText.speak(
      "O ônibus  da linha ${_nearestStop!.routeNumber}  está a $formattedDistance do seu ponto de embarque).",
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RouteBloc, RouteState>(
          listener: (context, state) {
            if (state is RouteLoading) {
              Maps.speakText.speak('Carregando mapa');
              const Center(child: CircularProgressIndicator());
            } else if (state is RouteLoaded) {
              _updateMarkersAndPolylines(state);
            } else if (state is RouteError) {
              const Center(child: Text('Erro ao carregar marcadores'));
            }
          },
        ),
        BlocListener<NearestStopCubit, StopBusModel?>(
          listener: (context, nearestStop) {
            if (nearestStop != null) {
              setState(() => _nearestStop = nearestStop);
              CustomLogger.logInfo(
                  "🚏 Ponto mais próximo atualizado: ${nearestStop.stopBus}");
            }
          },
        )
      ],
      child: GoogleMap(
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
      ),
    );
  }
}
