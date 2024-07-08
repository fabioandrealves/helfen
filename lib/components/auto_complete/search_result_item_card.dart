import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/model/google_maps/places/place.dart';

import '../../screens/map/map_display.dart';

class SearchResultsItemCard extends StatelessWidget {
  final Place result;
  final VoidCallback onTap;

  const SearchResultsItemCard(
      {super.key, required this.result, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(result.name!),
        subtitle: Text(result.formattedAddress!),
        onTap: () {
          final LatLng destination = result.geometry!.location!.latLng;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapBuilder(destination: destination),
            ),
          );
        },
      ),
    );
  }
}
