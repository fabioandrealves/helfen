import 'package:flutter/material.dart';

import '../infra/bus_route.dart';

class BusInformation extends StatelessWidget {
  final BusRoute busRoute;

  const BusInformation({super.key, required this.busRoute});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Route ${busRoute.routeNumber}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10.0),
          Text('Origin: ${busRoute.origin.key}'),
          Text('Destination: ${busRoute.destination.key}'),
        ],
      ),
    );
  }
}
