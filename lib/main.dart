import 'package:flutter/material.dart';
import 'package:helfen_bus/blocs/maps_location_bloc.dart';
import 'package:helfen_bus/mapS.dart';
import 'package:helfen_bus/screens/search_bus_route/search_bus_route_screen.dart';
import 'package:helfen_bus/services/dataBase/dataBaseHelper.dart';
import 'package:provider/provider.dart';

import 'infra/provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await Permission.location.request();
  DataBaseHelper databaseHelper = DataBaseHelper();
  await databaseHelper.initDatabase();

  Maps.speakText.speak("Olá. Seja bem-vindo ao meu aplicativo");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(create: (_) => MapsLocationController())
      ],
      child: const SearchBusRouteScreen(),
    ),
  );
}
