import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/blocs/geolocation/geolocation_bloc.dart';
import 'package:helfen_bus/screens/map/widgets/marker/route.dart';

import '../../blocs/geolocation/geolocation_state.dart';

class MapBuilder extends StatelessWidget {
  final LatLng destination;

  const MapBuilder({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Localização'),
      ),
      body: BlocBuilder<GeolocationBloc, GeolocationState>(
        builder: (context, state) {
          if (state is GeolocationLoaded) {
            return CreateRoute(
                currentLocation: state.position, destination: destination);
            // return MapScreen(
            //     destination: destination, currentLocation: state.position!);
          } else if (state is GeolocationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Text('erro ao obter localização'); // som
          }
        },
      ),
    );
  }
}

// _markers.add(_createMarker(
//     position: widget.destination,
//     hue: BitmapDescriptor.hueRose,
//     title: 'Destino'));
