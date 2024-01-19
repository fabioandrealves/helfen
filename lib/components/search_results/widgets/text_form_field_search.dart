import 'package:flutter/material.dart';
import 'package:helfen_bus/blocs/maps_location_bloc.dart';
import 'package:helfen_bus/components/search_results/widgets/search_results/card_results.dart';
import 'package:helfen_bus/infra/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../themes/color/scheme.dart';
import '../../../../themes/style/text_styles.dart';
import '../../../services/places_service.dart';

class TextFormSearchResults extends StatelessWidget {
  final Scheme scheme;
  final ThemeProvider themeProvider;
  final PlacesService placesService = PlacesService();

  TextFormSearchResults({
    Key? key,
    required this.scheme,
    required this.themeProvider,
  }) : super(key: key);

  OutlineInputBorder _buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(
        width: 10,
        color: color,
      ),
    );
  }

  InputDecoration _buildInputDecoration(
      ThemeProvider themeProvider, Scheme scheme) {
    return InputDecoration(
      labelText: "Pesquise aqui",
      labelStyle: themeProvider.isDarkMode
          ? TextStyles.textDarkOnSurface(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: scheme.surfaceVariant,
            )
          : TextStyles.textLightOnSurface(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: scheme.surfaceVariant,
            ),
      filled: true,
      fillColor:
          themeProvider.isDarkMode ? scheme.onBackground : scheme.onBackground,
      focusedBorder: _buildOutlineInputBorder(color: scheme.outline),
      enabledBorder: _buildOutlineInputBorder(color: scheme.outlineVariant),
    );
  }

  TextStyle _getTextFieldStyle(ThemeProvider themeProvider, Scheme scheme) =>
      themeProvider.isDarkMode
          ? TextStyles.textDarkOnSurface(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: scheme.inverseSurface,
            )
          : TextStyles.textLightOnSurface(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: scheme.inverseSurface,
            );

  Widget _buildSearchTextField(
          BuildContext context, MapsLocationController searchController) =>
      TextFormField(
        autofocus: true,
        onChanged: (searchText) {
          placesService.getPlaces(searchText).then((results) {
            searchController.getResults(results);
          });
        },
        style: _getTextFieldStyle(themeProvider, scheme),
        decoration: _buildInputDecoration(themeProvider, scheme),
      );

  @override
  Widget build(BuildContext context) {
    final mapsLocationController = Provider.of<MapsLocationController>(context);
    return Column(
      children: [
        _buildSearchTextField(context, mapsLocationController),
        CardResults(
          context: context,
          searchController: mapsLocationController,
        ),
      ],
    );
  }
}
