import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class RouteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRoute extends RouteEvent {}

class UpdateRoute extends RouteEvent {
  final List<MapEntry<Marker, Polyline>> route;

  UpdateRoute({required this.route});
}
