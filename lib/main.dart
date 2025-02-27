import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helfen_bus/components/search_results/controller/text_search_controller_provider.dart';
import 'package:helfen_bus/cubit/nearest_stop_cubit.dart';
import 'package:helfen_bus/screens/search_bus_route/home_screen.dart';
import 'package:mysql1/mysql1.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'blocs/geolocation/geolocation_bloc.dart';
import 'infra/bus_stop.dart';
import 'infra/dataBase/configuration/mysql_db_configuration.dart';
import 'infra/logger/custom_logger.dart';
import 'infra/provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.location.request();

  runApp(BlocStructure());
}

class BlocStructure extends StatefulWidget {
  final configuration = MySqlDBConfiguration();

  BlocStructure({super.key});

  @override
  State<BlocStructure> createState() => _BlocStructureState();
}

class _BlocStructureState extends State<BlocStructure> {
  @override
  void initState() {
    super.initState();
    _databaseConnection();
  }

  Future<void> _databaseConnection() async {
    final connection = await widget.configuration.connection;
    final result = await connection.query('SELECT * FROM bus_stops');
    for (ResultRow r in result) {
      StopBusModel stopBus = StopBusModel.fromData(r.fields);
      CustomLogger.logWarning(stopBus.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<TextSearchControllerProvider>(
          create: (_) => TextSearchControllerProvider(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GeolocationBloc>(
            create: (_) => GeolocationBloc(),
          ),
          BlocProvider<NearestStopCubit>(
            create: (_) => NearestStopCubit(),
          ),
        ],
        child: HomeScreen(
          configuration: widget.configuration,
        ),
      ),
    );
  }
}
