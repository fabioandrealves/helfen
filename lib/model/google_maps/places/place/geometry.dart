import 'package:helfen_bus/model/google_maps/places/place/viewport.dart';

import 'location.dart';

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({required this.location, this.viewport});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json["location"]),
      viewport:
          json["viewport"] != null ? Viewport.fromJson(json["viewport"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "location": location,
      "viewport": viewport,
    };
  }
}
