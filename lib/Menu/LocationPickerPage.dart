// Menu/LocationPickerPage.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({Key? key}) : super(key: key);

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  LatLng? selectedLocation;
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เลือกตำแหน่งบนแผนที่'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(17.9757, 102.6331), // Default to Vientiane
          zoom: 14,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
        },
        onTap: (LatLng position) {
          setState(() {
            selectedLocation = position;
          });
        },
        markers: selectedLocation != null
            ? {
                Marker(
                  markerId: const MarkerId('selected'),
                  position: selectedLocation!,
                ),
              }
            : {},
      ),
      floatingActionButton: selectedLocation != null
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.pop(context, selectedLocation);
              },
              label: const Text('เลือกตำแหน่งนี้'),
              icon: const Icon(Icons.check),
            )
          : null,
    );
  }
}
