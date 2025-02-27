import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/infra/logger/custom_logger.dart';
import 'package:helfen_bus/screens/map/widgets/marker/location_markers.dart';
import 'package:provider/provider.dart';

import '../../blocs/route/route_bloc.dart';
import '../../blocs/route/route_state.dart';
import '../../cubit/nearest_stop_cubit.dart';
import '../../infra/bus_stop.dart';
import '../../infra/http/mapS.dart';
import '../../infra/provider/theme_provider.dart';

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
  late LocationMarker _location;
  List<Marker> _markers = [];
  List<Polyline> _polylines = [];
  StopBusModel? _nearestStop;
  Marker? _busMarker;
  Timer? _speakTimer;
  String _mapsTheme = "";

  ThemeProvider get _themeProvider => Provider.of<ThemeProvider>(context);

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
    // _initializeLocationMarker();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 10), _simulateBusMovement);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadMapTheme();
    _initializeLocationMarker();
  }

  void _initializeLocationMarker() {
    _location = LocationMarker(
      currentLocation: widget.currentLocation,
      destination: widget.destination,
    );
  }

  void _loadMapTheme() {
    if (_themeProvider.isDarkMode) {
      DefaultAssetBundle.of(context)
          .loadString("assets/themes/dark_mode.json")
          .then((value) {
        setState(() => _mapsTheme = value);
      });
    } else {
      setState(() => _mapsTheme = "");
    }
  }

  @override
  void dispose() {
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
    _speakDistanceToBusDetailed();
  }

  void _manageSpeakTimer() {
    _speakTimer?.cancel();

    if (_busMarker == null || _nearestStop == null) {
      CustomLogger.logWarning(
          "⚠️ _manageSpeakTimer cancelado: _busMarker ou _nearestStop são nulos.");
      return;
    }

    double distance = _calculateDistanceByBusToNearestStop;
    CustomLogger.logInfo("📏 Distância calculada: $distance metros");

    if (distance >= 350 && distance <= 1000) {
      CustomLogger.logInfo("🔊 Executando _speakDistanceToBus...");
      _speakDistanceToBus();

      _speakTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
        if (_busMarker == null || _nearestStop == null) {
          CustomLogger.logError(
              "⚠️ Timer cancelado: _busMarker ou _nearestStop ficaram nulos.");
          timer.cancel();
          return;
        }

        double updatedDistance = _calculateDistanceByBusToNearestStop;
        CustomLogger.logInfo(
            "📏 Distância atualizada: $updatedDistance metros");

        if (updatedDistance < 350 || updatedDistance > 1000) {
          CustomLogger.logWarning(
              "⏹️ Distância fora do intervalo (350-1000m). Cancelando timer.");
          timer.cancel();
        } else {
          CustomLogger.logInfo("🔊 Repetindo _speakDistanceToBus...");
          _speakDistanceToBus();
        }
      });
    } else {
      CustomLogger.logError(
          "⏹️ Distância fora do intervalo inicial (350-1000m). Não iniciando timer.");
    }
  }

  void _speakDistanceToBusDetailed() {
    Maps.speakText.speak(
      "O ônibus  da linha ${_nearestStop!.routeNumber}  está a $formattedDistance do seu ponto de embarque).",
    );
  }

  void _speakDistanceToBus() {
    Maps.speakText.speak(
      "O ônibus está a $formattedDistance do seu ponto de embarque.",
    );
  }

  void _simulateBusMovement() {
    // const int steps = 12; // Número de passos da simulação

    const int steps = 3000; // Número de passos da simulação
    const Duration stepDuration =
        Duration(milliseconds: 10); // Intervalo entre passos
    int currentStep = 0;

    if (_busMarker == null || _nearestStop == null) return;

    LatLng startPosition = _busMarker!.position;
    LatLng endPosition = LatLng(
      _nearestStop!.stopBus.latitude,
      _nearestStop!.stopBus.longitude,
    );

    double deltaLat = (endPosition.latitude - startPosition.latitude) / steps;
    double deltaLng = (endPosition.longitude - startPosition.longitude) / steps;

    Timer.periodic(stepDuration, (timer) {
      if (currentStep >= steps) {
        timer.cancel();
        return;
      }

      setState(() {
        _busMarker = _busMarker!.copyWith(
          positionParam: LatLng(
            startPosition.latitude + deltaLat * currentStep,
            startPosition.longitude + deltaLng * currentStep,
          ),
        );
        _markers.removeWhere((m) => m.markerId == _busMarker!.markerId);
        _markers.add(_busMarker!);
      });
      _manageSpeakTimer();
      currentStep++;
    });
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Carregando rota..."),
          ],
        ),
      ),
    );
  }

  void _hideLoadingDialog() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RouteBloc, RouteState>(
          listener: (context, state) {
            if (state is RouteLoading) {
              _showLoadingDialog();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Maps.speakText.speak('Carregando rota');
              });
            } else if (state is RouteLoaded) {
              _updateMarkersAndPolylines(state);
              _hideLoadingDialog();
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
      child: ExcludeSemantics(
        child: GoogleMap(
          style: _mapsTheme,
          mapType: MapType.normal,
          onMapCreated: (controller) {
            _completer.complete(controller);
          },
          initialCameraPosition: CameraPosition(
            target: widget.destination,
            zoom: 15.0,
          ),
          markers: _markers.toSet(),
          polylines: _polylines.toSet(),
        ),
      ),
    );
  }
}
