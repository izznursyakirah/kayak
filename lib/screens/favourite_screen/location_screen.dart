import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen ({Key? key}) : super(key: key);

  @override
  State<LocationScreen > createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController mapController;
  LatLng? _userLocation;
  final LatLng _initialCameraPosition = const LatLng(4.21376659279996, 102.15555007999579);
  final double _zoomLevel = 14.0; 
  final _auth = FirebaseAuth.instance;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _initialCameraPosition, 
              zoom: 6.9, 
            ),
            markers: _userLocation != null
                ? {
                    Marker(
                      markerId: MarkerId('user_location'),
                      position: _userLocation!,
                    ),
                  }
                : {},
          ),
        ],
      ),
    );
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
    });

    await userLocation(position.latitude, position.longitude);

    _zoomToUserLocation(position.latitude, position.longitude);
  }

  Future<void> userLocation(double? latitude, double? longitude) async {
    await FirebaseFirestore.instance.collection('user_location').add({
      'User': currentUser?.uid,
'latitude': latitude,
      'longitude': longitude,
    });
  }

  void _zoomToUserLocation(double latitude, double longitude) {
    mapController.animateCamera(CameraUpdate.newLatLngZoom(
      LatLng(latitude, longitude), 
      _zoomLevel,
    ));
  }
}