import 'package:flutter/cupertino.dart';

import '../../../../http/places_api/model/result.dart';

class TextSearchController with ChangeNotifier {
  List<Result> _results = [];

  List<Result> get results => _results;

  void getResults(List<Result> results) {
    _results = results;
    notifyListeners();
  }
}
