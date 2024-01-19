import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/http/logger/custom_logger.dart';
import 'package:helfen_bus/http/places_api/model/results_model/geometry.dart';
import 'package:helfen_bus/http/places_api/model/results_model/location.dart';
import 'package:helfen_bus/http/places_api/model/results_model/place.dart';
import 'package:helfen_bus/services/geolocator_service.dart';
import 'package:helfen_bus/services/marker_service.dart';
import 'package:helfen_bus/services/places_service.dart';
import 'package:helfen_bus/services/text_to_speech/text_to_speech_config.dart';

import '../http/places_api/model/result.dart';

class MapsLocationController extends ChangeNotifier {
  final geoLocatorService = GeoLocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();
  final textToSpeech = TextToSpeech();

  late Position? currentLocation;
  Place? selectedLocationStatic;
  String? placeType;
  List<Result>? results = [];
  StreamController<Place?> selectedLocation = StreamController<Place>();

  MapsLocationController() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    try {
      currentLocation = await geoLocatorService.getCurrentLocation();
      selectedLocationStatic = Place(
        name: null,
        geometry: Geometry(
          location: Location(
            latLng:
                LatLng(currentLocation!.latitude, currentLocation!.longitude),
          ),
        ),
      );
      CustomLogger.logToLogcat(
          tag: "Position",
          subTag: "setCurrentLocation",
          message: "Location obtained successfully",
          logLevel: AndroidLogLevel.info);
    } catch (error) {
      CustomLogger.logToLogcat(
          tag: "Position",
          subTag: "setCurrentPosition",
          message: "Error getting current position",
          logLevel: AndroidLogLevel.error);
    }
    notifyListeners();
  }

  void getResults(List<Result> searchText) {
    results = searchText;
    notifyListeners();
  }

  clearSelectedLocation() {
    selectedLocation.add(null);
    results = null;
    notifyListeners();
  }
}
