import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/components/search_results/controller/text_search_controller_provider.dart';
import 'package:helfen_bus/screens/map/map_display.dart';

class SearchResults extends StatelessWidget {
  final BuildContext context;
  final TextSearchControllerProvider search;

  const SearchResults({
    Key? key,
    required this.context,
    required this.search,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: search.results!
            .where((result) =>
                result.name != null && result.formattedAddress != null)
            .map(
              (result) => Card(
                child: ListTile(
                  title: Text(result.name!),
                  subtitle: Text(result.formattedAddress!),
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
            )
            .toList(),
      ),
    );
  }
}
// return ListView(
//   children: searchController.results!
//       .map(
//         (result) => Card(
//           child: ListTile(
//             title: Text(result.name),
//             subtitle: Text(result.formattedAddress),
//             onTap: () {
//               searchController.setCurrentLocation(
//                   searchController.results[index].placeId);
//               final LatLng destination = result.geometry.location.latLng;
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => MapDisplay(
//                       mapLocationController: searchController,
//                       destination: destination),
//                 ),
//               );
//             },
//           ),
//         ),
//       )
//       .toList(),
// );
