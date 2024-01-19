import 'package:helfen_bus/http/places_api/model/result.dart';

class PlaceResponse {
  List<Result>? results;
  String? status;

  PlaceResponse({this.results, this.status});

  PlaceResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((x) {
        results!.add(Result.fromJson(x));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((x) => x.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}
