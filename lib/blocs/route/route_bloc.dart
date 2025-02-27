import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/blocs/route/route_event.dart';
import 'package:helfen_bus/blocs/route/route_state.dart';
import 'package:helfen_bus/cubit/nearest_stop_cubit.dart';

import '../../infra/bus_stop.dart';
import '../../infra/dataBase/DAO/stop_bus_DAO.dart';
import '../../infra/logger/custom_logger.dart';
import '../../screens/map/marker/marker_helper.dart';
import '../../screens/map/polyline/polyline_helper.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final NearestStopCubit nearestStopCubit;
  final StopBusDAO stopBusDAO;
  final Position? currentLocation;
  final LatLng destination;
  final PolylineHelper _polylineHelper = PolylineHelper();
  final MarkerHelper _markerHelper = MarkerHelper();

  RouteBloc({
    required this.nearestStopCubit,
    required this.stopBusDAO,
    required this.currentLocation,
    required this.destination,
  }) : super(RouteInitial()) {
    on<LoadRoute>(_onLoadRoute);
    on<UpdateRoute>(_onUpdateRoute);
    add(LoadRoute());
  }

  Future<void> _onLoadRoute(LoadRoute event, Emitter<RouteState> emit) async {
    try {
      emit(RouteLoading());
      final markersAndPolylines = await _buildMarkersAndPolylines();
      emit(RouteLoaded(route: markersAndPolylines));
    } catch (e) {
      emit(RouteError(message: e.toString()));
    }
  }

  void _onUpdateRoute(UpdateRoute event, Emitter<RouteState> emit) {
    emit(RouteInitial());
  }

  Future<List<MapEntry<Marker, Polyline>>> _buildMarkersAndPolylines() async {
    final stops = await stopBusDAO.findAll();
    final nearestStop = _findNearestStop(currentLocation!, stops);
    final nearestDestinationStop = _findNearestStop(destination, stops);

    if (nearestStop == null || nearestDestinationStop == null) {
      CustomLogger.logWarning(
          'Nenhum ponto próximo encontrado para a localização atual ou destino.');
      return [];
    }

    CustomLogger.logWarning(
        'Ponto mais próximo de currentPosition: ${nearestStop.stopBus}');
    CustomLogger.logWarning(
        'Ponto mais próximo do Destino: ${nearestDestinationStop.stopBus}');
    nearestStopCubit.updateNearestStop(stop: nearestStop);

    final relevantStops = _getRelevantStops(
      stops: stops,
      stopCurrentRouteNumber: nearestStop.routeNumber,
      stopCurrentIsOutbound: nearestStop.isOutbound,
    );
    CustomLogger.logInfo('Relevant Stops: ${relevantStops.length}');
    return _createMarkersAndPolylines(relevantStops);
  }

  StopBusModel? _findNearestStop(dynamic point, List<StopBusModel> stops) {
    double minDistance = double.infinity;
    StopBusModel? nearestStop;

    for (final stop in stops) {
      final distance = Geolocator.distanceBetween(
        point is Position ? point.latitude : point.latitude,
        point is Position ? point.longitude : point.longitude,
        stop.stopBus.latitude,
        stop.stopBus.longitude,
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearestStop = stop;
      }
    }

    return nearestStop;
  }

  List<StopBusModel> _getRelevantStops(
      {required List<StopBusModel> stops,
      required int stopCurrentRouteNumber,
      required bool stopCurrentIsOutbound}) {
    return stops
        .where((stop) =>
            stop.routeNumber == stopCurrentRouteNumber &&
            stop.isOutbound == stopCurrentIsOutbound)
        .toList();
  }

  Future<List<MapEntry<Marker, Polyline>>> _createMarkersAndPolylines(
      List<StopBusModel> relevantStops) async {
    final List<MapEntry<Marker, Polyline>> markerPolylineEntries = [];
    List<LatLng> routePoints = [];

    for (int i = 0; i < relevantStops.length; i++) {
      final marker = await _markerHelper.createMarker(
        position: LatLng(
          relevantStops[i].stopBus.latitude,
          relevantStops[i].stopBus.longitude,
        ),
        assetName: _markerHelper.getMarkerAsset(
            index: i, totalStops: relevantStops.length),
        title: 'Parada $i',
      );

      routePoints.add(LatLng(
        relevantStops[i].stopBus.latitude,
        relevantStops[i].stopBus.longitude,
      ));

      if (i > 0) {
        final polylineCoordinates =
            await _polylineHelper.getPolylineCoordinates(
          routePoints[i - 1],
          routePoints[i],
        );
        final polyline = _polylineHelper.createPolyline(polylineCoordinates, i);
        markerPolylineEntries.add(MapEntry(marker, polyline));
      }
    }

    return markerPolylineEntries;
  }
}
