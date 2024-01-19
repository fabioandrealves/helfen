import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helfen_bus/blocs/maps_location_bloc.dart';

import '../../../../screens/map/map_display.dart';

class CardResults extends StatelessWidget {
  final BuildContext context;
  final MapsLocationController searchController;

  const CardResults({
    Key? key,
    required this.context,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: searchController.results!
            .where((result) =>
                result.name != null && result.formattedAddress != null)
            .map((result) {
          return Card(
            child: ListTile(
              title: Text(result.name!),
              subtitle: Text(result.formattedAddress!),
              onTap: () {
                final LatLng destination = result.geometry!.location!.latLng;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapDisplay(
                      mapLocationController: searchController,
                      destination: destination,
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
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
