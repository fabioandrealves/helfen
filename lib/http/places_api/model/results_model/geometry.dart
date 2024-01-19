import 'package:helfen_bus/http/places_api/model/results_model/viewport.dart';

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

//

  // Geometry.fromJson(Map<String, dynamic> json) {
  //   location = (json['location'] != null
  //       ? Location.fromJson(json['location'])
  //       : null)!;
  //   viewport =
  //       json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> json = <String, dynamic>{};
  //   json['location'] = location.toJson();
  //   if (viewport != null) {
  //     json['viewport'] = viewport!.toJson();
  //   }
  //   return json;
  // }
}
