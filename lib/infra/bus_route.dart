import 'dart:core';

class BusRouteModel {
  final int routeNumber;
  final MapEntry<String, String> originInfo;
  final MapEntry<String, String> destinationInfo;

  BusRouteModel({
    required this.routeNumber,
    required this.originInfo,
    required this.destinationInfo,
  });

  factory BusRouteModel.fromData(Map<String, dynamic> data) {
    return BusRouteModel(
        routeNumber: data['route_number'].toInt(),
        originInfo: MapEntry<String, String>(
          data['origin_city'].toString(),
          data['origin_place'].toString(),
        ),
        destinationInfo: MapEntry<String, String>(
          data['destination_city'].toString(),
          data['destination_place'].toString(),
        ));
  }

  Map<String, dynamic> toData() {
    return {
      'route_number': routeNumber,
      'origin_city': originInfo.key,
      'origin_place': originInfo.value,
      'destination_city': destinationInfo.key,
      'destination_place': destinationInfo.value,
    };
  }

  @override
  String toString() {
    return '\n\tBusRoute\n'
        '\t\t{\n'
        '\t\t\trouteNumber: $routeNumber,\n'
        '\t\t\torigin_city: ${originInfo.key},\n'
        '\t\t\torigin_place: ${originInfo.value},\n'
        '\t\t\tdestination_city: ${destinationInfo.key},\n'
        '\t\t\torigin_place: ${destinationInfo.value}\n'
        '\t\t}\n';
  }
}
