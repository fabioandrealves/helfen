import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class RouteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RouteInitial extends RouteState {}

class RouteLoading extends RouteState {}

class RouteLoaded extends RouteState {
  final List<MapEntry<Marker, Polyline>> route;
  RouteLoaded({required this.route});
}

class RouteError extends RouteState {
  final String message;

  RouteError({required this.message});
}
