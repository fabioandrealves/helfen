import 'package:flutter/material.dart';
import 'package:helfen_bus/screens/place_database/place_database_screen.dart';

class PlacesDatabaseButton extends StatelessWidget {
  const PlacesDatabaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PlacesDatabaseScreen()));
      },
      child: const Icon(Icons.data_usage),
    );
  }
}
