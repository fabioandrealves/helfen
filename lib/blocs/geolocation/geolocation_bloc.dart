import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helfen_bus/blocs/geolocation/geolocation_event.dart';
import 'package:helfen_bus/blocs/geolocation/geolocation_state.dart';

import '../../infra/http/services/geolocator_service.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeoLocationService geolocation = GeoLocationService();

  GeolocationBloc() : super(GeolocationLoading()) {
    on<LoadGeolocation>((event, emit) async {
      try {
        final currentPosition = await geolocation.getCurrentLocation();
        emit(GeolocationLoaded(position: currentPosition));
      } catch (_) {
        emit(GeolocationError());
      }
    });
    add(LoadGeolocation());
    on<UpdateGeolocation>((event, emit) {
      emit(GeolocationLoading());
    });
  }
}
