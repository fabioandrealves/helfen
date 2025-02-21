// import 'package:flutter/cupertino.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:helfen_bus/screens/map/polyline/polyline_helper.dart';
//
// import '../../infra/bus_stop.dart';
// import '../../infra/dataBase/DAO/stop_bus_DAO.dart';
// import '../../infra/logger/custom_logger.dart';
// import 'marker/marker_helper.dart';
//
// class RouteBuilder extends StatefulWidget {
//   final StopBusDAO? stopBusDAO;
//   final Position? currentLocation;
//   final LatLng? destination;
//
//   const RouteBuilder({
//     super.key,
//     required this.stopBusDAO,
//     this.currentLocation,
//     required this.destination,
//   });
//
//   @override
//   State<RouteBuilder> createState() => _RouteBuilderState();
// }
//
// class _RouteBuilderState extends State<RouteBuilder> {
//   final PolylineHelper _polylineHelper = PolylineHelper();
//   final MarkerHelper _markerHelper = MarkerHelper();
//   List<MapEntry<Marker, Polyline>> _markersAndPolylines = [];
//   List<StopBusModel> _stops = [];
//   StopBusModel? _nearestStop;
//   StopBusModel? _nearestDestinationStop;
//   List<LatLng> _routePoints = [];
//
//
//   Future<List<MapEntry<Marker, Polyline>>> _buildMarkersAndPolylines() async {
//     _stops = await widget.stopBusDAO!.findAll();
//     _nearestStop = _findNearestStop(widget.currentLocation!, _stops);
//     _nearestDestinationStop = _findNearestStop(widget.destination, _stops);
//
//     if (_nearestStop == null || _nearestDestinationStop == null) {
//       CustomLogger.logWarning(
//           'Nenhum ponto próximo encontrado para a localização atual ou destino.');
//       return [];
//     }
//
//     CustomLogger.logWarning(
//         'Ponto mais próximo de currentPosition: ${_nearestStop!.stopBus}');
//     CustomLogger.logWarning(
//         'Ponto mais próximo do Destino: ${_nearestDestinationStop!.stopBus}');
//
//     return _createMarkersAndPolylines(relevantStops: relevantStops);
//   }
//
//   StopBusModel? _findNearestStop(dynamic point, List<StopBusModel> stops) {
//     double minDistance = double.infinity;
//     StopBusModel? nearestStop;
//
//     for (final stop in stops) {
//       final distance = Geolocator.distanceBetween(
//         point is Position ? point.latitude : point.latitude,
//         point is Position ? point.longitude : point.longitude,
//         stop.stopBus.latitude,
//         stop.stopBus.longitude,
//       );
//
//       if (distance < minDistance) {
//         minDistance = distance;
//         nearestStop = stop;
//       }
//     }
//
//     return nearestStop;
//   }
//
//   List<StopBusModel> get relevantStops {
//     if (_nearestStop == null || _nearestDestinationStop == null) return [];
//
//     return _stops
//         .where((stop) =>
//             stop.routeNumber == _nearestStop!.routeNumber &&
//             stop.routeNumber == _nearestDestinationStop!.routeNumber &&
//             stop.isOutbound == _nearestStop!.isOutbound &&
//             stop.isOutbound == _nearestDestinationStop!.isOutbound)
//         .toList();
//   }
//
//   Future<List<MapEntry<Marker, Polyline>>> _createMarkersAndPolylines(
//       {required List<StopBusModel> relevantStops}) async {
//     final List<MapEntry<Marker, Polyline>> markerPolylineEntries = [];
//     List<LatLng> routePoints = [];
//
//     for (int i = 0; i < relevantStops.length; i++) {
//       final marker = await _markerHelper.createMarker(
//         position: LatLng(
//           relevantStops[i].stopBus.latitude,
//           relevantStops[i].stopBus.longitude,
//         ),
//         assetName: _markerHelper.getMarkerAsset(
//             index: i, totalStops: relevantStops.length),
//         title: 'Parada ${i + 1}',
//       );
//
//       routePoints.add(LatLng(
//         relevantStops[i].stopBus.latitude,
//         relevantStops[i].stopBus.longitude,
//       ));
//
//       if (i > 0) {
//         final polylineCoordinates =
//             await _polylineHelper.getPolylineCoordinates(
//           routePoints[i - 1],
//           routePoints[i],
//         );
//         final polyline = _polylineHelper.createPolyline(polylineCoordinates, i);
//         markerPolylineEntries.add(MapEntry(marker, polyline));
//       }
//     }
//
//     return markerPolylineEntries;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: relevantStops.length,
//       itemBuilder: (context, index) async {
//       final marker = await _markerHelper.createMarker(
//         position: LatLng(
//           relevantStops[index].stopBus.latitude,
//           relevantStops[index].stopBus.longitude,
//         ),
//         assetName: _markerHelper.getMarkerAsset(
//             index: imdex, totalStops: relevantStops.length),
//         title: 'Parada ${index + 1}',
//       );
//
//       routePoints.add(LatLng(
//         relevantStops[index].stopBus.latitude,
//         relevantStops[index].stopBus.longitude,
//       ));
//
//       if (i > 0) {
//         final polylineCoordinates =
//             await _polylineHelper.getPolylineCoordinates(
//           routePoints[i - 1],
//           routePoints[i],
//         );
//         final polyline = _polylineHelper.createPolyline(polylineCoordinates, index);
//         markerPolylineEntries.add(MapEntry(marker, polyline));
//       },
//     );
//   }
// }
