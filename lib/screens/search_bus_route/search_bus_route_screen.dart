import 'package:flutter/material.dart';
import 'package:helfen_bus/infra/dataBase/configuration/mysql_db_configuration.dart';
import 'package:helfen_bus/screens/search_bus_route/widgets/side_menu.dart';
import 'package:helfen_bus/themes/app_themes.dart';
import 'package:provider/provider.dart';

import '../../infra/bus_route.dart';
import '../../infra/dataBase/DAO/bus_route_DAO.dart';
import '../../infra/provider/theme_provider.dart';
import 'widgets/text_form_field_search_results.dart';

class SearchBusRouteScreen extends StatefulWidget {
  final MySqlDBConfiguration configuration;
  const SearchBusRouteScreen({super.key, required this.configuration});

  @override
  State<SearchBusRouteScreen> createState() => _SearchBusRouteScreenState();
}

class _SearchBusRouteScreenState extends State<SearchBusRouteScreen> {
  late BusRouteDAO _busRouteDAO;
  late BusRouteModel busRoute;
// late List<BusRoute> allBusRoutes = [];

  @override
  void initState() {
    super.initState();
    _busRouteDAO = BusRouteDAO(configuration: widget.configuration);
    // _initializeBusRouteDAO();
  }

  // Future<void> _initializeBusRouteDAO() async {
  //   _busRouteDAO = BusRouteDAO(configuration: widget.configuration);
  //   try {
  //     final route = await _busRouteDAO.findOne(628);
  //     setState(() {
  //       busRoute = route!;
  //     });
  //     CustomLogger.logWarning(busRoute.toString());
  //   } catch (e) {
  //     CustomLogger.logError('Error fetching bus routes: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final appThemes = AppThemes(
          themeProvider: themeProvider,
          seedColor: const Color(0xff93c741),
        );
        final scheme = appThemes.getScheme(context);

        return MaterialApp(
          themeMode: ThemeMode.system,
          theme: appThemes.getTheme(context),
          home: Scaffold(
            drawer: SideMenu(
              themeProvider: themeProvider,
            ),
            appBar: AppBar(
              title: const Text("Helfen"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormSearchResults(
                scheme: scheme,
                themeProvider: themeProvider,
              ),
            ),
          ),
        );
      },
    );
  }
}

//bd
// late BusRouteDAO _busRouteDAO;
// late BusRoute busRoute;
// // late List<BusRoute> allBusRoutes = [];
//
// @override
// void initState() {
//   super.initState();
//   _initializeBusRouteDAO();
// }
//
// Future<void> _initializeBusRouteDAO() async {
//   _busRouteDAO = BusRouteDAO(configuration: widget.configuration);
//   try {
//     final route = await _busRouteDAO.findOne(628);
//     setState(() {
//       busRoute = route;
//     });
//     CustomLogger.logWarning(busRoute.toString());
//   } catch (e) {
//     CustomLogger.logError('Error fetching bus routes: $e');
//   }
// }

// class SearchBusRouteScreen extends StatelessWidget {
//   final BusRouteDAO busRouteDAO;
//   final BusStopDAO busStopDAO;
//
//   const SearchBusRouteScreen(
//       {Key? key, required this.busRouteDAO, required this.busStopDAO})
//       : super(key: key);
//

//TextFormSearchText(theme: theme),
// const SizedBox(height: 20),
// ListView.builder(
//   shrinkWrap:
//       true, // Defina shrinkWrap como true para evitar problemas de tamanho no ListView.
//   itemCount: locationSearch.searchResults.results!.length,
//   itemBuilder: (context, index) {
//     final placeResponse = locationSearch.searchResults;
//
//     return Column(
//       children: placeResponse.results!.map((data) {
//         return ListTile(
//           title: Text(data.name ?? "desconhecido"),
//           subtitle:
//               Text(data.formattedAddress ?? "desconhecido"),
//         );
//

//
// import 'package:flutter/material.dart';
// import 'package:helfen_bus/Widgets/bus_information.dart';
// import 'package:provider/provider.dart';
//
// import '../infra/provider/route_provider.dart';
// import '../infra/provider/theme_provider.dart';
// import '../themes/app_themes.dart';
//
// class InitialScreen extends StatelessWidget {
//   AppThemes theme = AppThemes(ThemeProvider(), const Color(0xff93c741).value);
//
//   InitialScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final routeProvider = Provider.of<RouteProvider>(context);
//
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               onChanged: (searchText) {
//                 routeProvider.searchBusRoutes(searchText);
//               },
//               decoration: InputDecoration(
//                 labelText: "Digite o número da linha ou destino",
//                 suffixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius:
//                   BorderRadius.circular(10.0), // Raio do canto da borda
//                   borderSide: BorderSide(
//                     color: theme.getTextFieldBorderColor(context),
//                     width: 3.0, // Largura da borda
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius:
//                   BorderRadius.circular(10.0), // Raio do canto da borda
//                   borderSide: BorderSide(
//                     color: theme.getTextFieldBorderColor(context),
//                     width: 3.0, // Largura da borda quando o campo está focado
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(child:
//             Consumer<RouteProvider>(builder: (context, provider, child) {
//               return GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 1,
//                       crossAxisSpacing: 10.0,
//                       mainAxisSpacing: 10.0),
//                   itemCount: routeProvider.searchResults.length,
//                   itemBuilder: (context, index) {
//                     final busRoute = routeProvider.searchResults[index];
//                     return GestureDetector(
//                       onTap: () {},
//                       child: BusInformation(busRoute: busRoute),
//                     );
//                   });
//             }))
//           ],
//         ),
//       ),
//     );
//   }
// }

// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => MapDisplay(
//       origin: busRoute.origin.value,
//       destination: busRoute.destination.value,
//       busStops: busRoute.busStops
//           .map((entry) => entry.value)
//           .toList(),
//     ),
//   ),
// );
