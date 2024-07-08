class PointLatLng {
  const PointLatLng(this.latitude, this.longitude);

  final double latitude;

  final double longitude;

  @override
  String toString() {
    return "lat: $latitude / longitude: $longitude";
  }
}
