import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/blocs/route/route_bloc.dart';
import 'package:helfen_bus/cubit/nearest_stop_cubit.dart';
import 'package:helfen_bus/screens/map/map_screen.dart';

import '../../../../blocs/route/route_event.dart';
import '../../../../infra/dataBase/DAO/stop_bus_DAO.dart';
import '../../../../infra/http/mapS.dart';

class CreateRoute extends StatefulWidget {
  final Position? currentLocation;
  final LatLng destination;

  const CreateRoute(
      {super.key, this.currentLocation, required this.destination});

  @override
  State<CreateRoute> createState() => _CreateRouteState();
}

class _CreateRouteState extends State<CreateRoute> {
  late StopBusDAO _stopBusDAO;

  NearestStopCubit get _nearestStopCubit =>
      BlocProvider.of<NearestStopCubit>(context);

  @override
  void initState() {
    super.initState();
    _stopBusDAO = StopBusDAO(configuration: Maps.configuration);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RouteBloc(
          nearestStopCubit: _nearestStopCubit,
          stopBusDAO: _stopBusDAO,
          currentLocation: widget.currentLocation,
          destination: widget.destination)
        ..add(LoadRoute()),
      child: MapView(
        currentLocation: widget.currentLocation!,
        destination: widget.destination,
      ),
    );
  }
}
