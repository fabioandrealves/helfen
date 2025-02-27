import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/blocs/geolocation/geolocation_bloc.dart';
import 'package:helfen_bus/screens/map/widgets/marker/route.dart';

import '../../blocs/geolocation/geolocation_state.dart';
import '../../infra/http/mapS.dart';

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
        title: const Text('Mapa'),
        leading: Semantics(
          button: true,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              semanticLabel: 'Voltar para a tela anterior',
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: BlocBuilder<GeolocationBloc, GeolocationState>(
        builder: (context, state) {
          if (state is GeolocationLoaded) {
            return CreateRoute(
                currentLocation: state.position, destination: destination);
          } else if (state is GeolocationLoading) {
            Maps.speakText.speak('Carregando mapa.');
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Carregando mapa..."),
                ],
              ),
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
