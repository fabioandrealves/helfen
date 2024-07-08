class PolylineWayPoint {
  String location;

  bool stopOver;

  PolylineWayPoint({required this.location, this.stopOver = true});

  @override
  String toString() {
    if (stopOver) {
      return location;
    } else {
      return "via:$location";
    }
  }
}
