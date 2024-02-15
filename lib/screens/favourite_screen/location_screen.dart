import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kayak/screens/favourite_screen/widgets/single_favourite_item.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class LocationScreen extends StatelessWidget {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: _determinePosition(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          Position? currentPosition = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Location Screen",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: Column(
              children: [
                Text(
                  'Latitude: ${currentPosition?.latitude}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Longitude: ${currentPosition?.longitude}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );

        }
      },
    );
  }
}
