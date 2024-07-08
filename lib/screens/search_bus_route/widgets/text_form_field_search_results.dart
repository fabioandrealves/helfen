import 'package:flutter/material.dart';
import 'package:helfen_bus/infra/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../themes/color/scheme.dart';
import '../../../../themes/style/text_styles.dart';
import '../../../components/auto_complete/search_results.dart';
import '../../../components/search_results/controller/text_search_controller_provider.dart';
import '../../../infra/http/services/google_maps/places_service.dart';

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
          {required BuildContext context,
          required TextSearchControllerProvider search}) =>
      TextFormField(
        autofocus: true,
        onChanged: (searchText) {
          placesService.searchPlaces(searchText).then((results) {
            search.getResults(results);
          });
        },
        style: _getTextFieldStyle(themeProvider, scheme),
        decoration: _buildInputDecoration(themeProvider, scheme),
      );

  @override
  Widget build(BuildContext context) {
    final searchPlaces = context.watch<TextSearchControllerProvider>();
    return Column(
      children: [
        _buildSearchTextField(context: context, search: searchPlaces),
        SearchResults(
          context: context, search: searchPlaces,
          // search: searchResults,
        ),
      ],
    );
  }
}
