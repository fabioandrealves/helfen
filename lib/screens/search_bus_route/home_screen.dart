import 'package:flutter/material.dart';
import 'package:helfen_bus/infra/dataBase/configuration/mysql_db_configuration.dart';
import 'package:helfen_bus/screens/search_bus_route/widgets/side_menu.dart';
import 'package:helfen_bus/screens/search_bus_route/widgets/side_menu/side_menu_button.dart';
import 'package:helfen_bus/themes/app_themes.dart';
import 'package:helfen_bus/themes/style/percentage_extension.dart';
import 'package:provider/provider.dart';

import '../../infra/bus_route.dart';
import '../../infra/dataBase/DAO/bus_route_DAO.dart';
import '../../infra/provider/theme_provider.dart';
import 'widgets/text_form_field_search_results.dart';

class HomeScreen extends StatefulWidget {
  final MySqlDBConfiguration configuration;

  const HomeScreen({super.key, required this.configuration});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _menuKey = GlobalKey<ScaffoldState>();
  late BusRouteDAO _busRouteDAO;
  late BusRouteModel busRoute;

  @override
  void initState() {
    super.initState();
    _busRouteDAO = BusRouteDAO(configuration: widget.configuration);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
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
            key: _menuKey,
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: SideMenuButton(menuKey: _menuKey),
            drawer: SideMenu(
              themeProvider: themeProvider,
              menuKey: _menuKey,
            ),
            body: Padding(
              padding:
                  EdgeInsets.only(top: screenSize.height * 15.00.percent()),
              child: TextFormFieldSearchResults(
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
