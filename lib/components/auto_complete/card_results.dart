import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/components/search_results/controller/text_search_controller_provider.dart';
import 'package:helfen_bus/screens/map/map_builder.dart';
import 'package:helfen_bus/themes/style/percentage_extension.dart';

class CardResult extends StatelessWidget {
  final BuildContext context;
  final TextSearchControllerProvider search;

  const CardResult({
    Key? key,
    required this.context,
    required this.search,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Expanded(
      child: ListView(
        children: search.results!
            .where((result) =>
                result.name != null && result.formattedAddress != null)
            .map(
              (result) => Container(
                width: screenSize.width * 85.0.percent(),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: Text(
                      result.name!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      result.formattedAddress!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: const Icon(Icons.location_on),
                    onTap: () {
                      final LatLng destination =
                          result.geometry!.location!.latLng;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MapBuilder(destination: destination),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
