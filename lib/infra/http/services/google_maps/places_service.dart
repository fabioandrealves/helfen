import 'dart:convert' as convert;

import 'package:helfen_bus/model/google_maps/places/place.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

import '../../../logger/http_Interceptors.dart';
import '../../mapS.dart';

class PlacesService {
  String url =
      "https://maps.googleapis.com/maps/api/place/textsearch/json?query=";

  http.Client client = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
    ],
  );

  Future<List<Place>> searchPlaces(String query) => _searchPlaces(query);

  Future<List<Place>> _searchPlaces(String query) async {
    final response = await client.get(
      Uri.parse("$url${Uri.encodeQueryComponent(query)}&key=${Maps.apiKey}"),
    );
    final json = convert.jsonDecode(response.body);
    final List<dynamic> jsonResults = json['results'];
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
