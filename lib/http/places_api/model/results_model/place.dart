import 'package:helfen_bus/http/places_api/model/results_model/geometry.dart';

class Place {
  final String? name;
  final Geometry? geometry;
  final String? vicinity;

  Place({this.name, this.geometry, this.vicinity});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json["name"],
      geometry: (json['geometry'] != null
          ? Geometry.fromJson(json['geometry'])
          : null)!,
      vicinity: json['vicinity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "geometry": geometry,
      "vicinity": vicinity,
    };
  }
//
}
