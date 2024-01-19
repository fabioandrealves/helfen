import 'package:flutter/cupertino.dart';

import '../../services/dataBase/DAO/bus_route_DAO.dart';
import '../bus_route.dart';

class RouteProvider extends ChangeNotifier {
  final BusRouteDAO busRouteDAO;

  RouteProvider({required this.busRouteDAO});

  List<BusRoute> _searchResults = [];

  List<BusRoute> get searchResults => _searchResults;

  Future<void> searchBusRoutes(String searchText) async {
    if (searchText.isEmpty) {
      _searchResults.clear();
      notifyListeners();
      return;
    }

    final results = await busRouteDAO.searchBusRoutes(searchText);

    _searchResults = results;
    notifyListeners();
  }
}
