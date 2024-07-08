import 'package:flutter/cupertino.dart';

import '../../../model/google_maps/places/place.dart';

class TextSearchControllerProvider with ChangeNotifier {
  List<Place> _results = [];

  List<Place>? get results => _results;

  void getResults(List<Place> results) {
    _results = results;
    notifyListeners();
  }
}
