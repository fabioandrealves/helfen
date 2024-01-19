import 'dart:convert' as convert;

import 'package:helfen_bus/http/logger/http_Interceptors.dart';
import 'package:helfen_bus/http/places_api/model/result.dart';
import 'package:helfen_bus/mapS.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class PlacesService {
  String url =
      "https://maps.googleapis.com/maps/api/place/textsearch/json?query=";

  http.Client client = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
    ],
  );

  Future<List<Result>> getPlaces(String query) => _searchPlaces(query);

  Future<List<Result>> _searchPlaces(String query) async {
    final response = await client.get(
      Uri.parse("$url${Uri.encodeQueryComponent(query)}&key=${Maps.apiKey}"),
    );
    final json = convert.jsonDecode(response.body);
    final List<dynamic> jsonResults = json['results'];
    return jsonResults.map((place) => Result.fromJson(place)).toList();
  }
}
