import '../PointLatLng.dart';

class PolylineResult {
  String? status;

  List<PointLatLng> points;

  String? errorMessage;

  PolylineResult({this.status, this.points = const [], this.errorMessage = ""});
}
