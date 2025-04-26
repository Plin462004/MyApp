// Menu/map.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'เลือกตำแหน่ง',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LocationSelectorPage(),
    );
  }
}

class LocationSelectorPage extends StatefulWidget {
  @override
  _LocationSelectorPageState createState() => _LocationSelectorPageState();
}

class _LocationSelectorPageState extends State<LocationSelectorPage> {
  LatLng? currentLocation;
  LatLng? destinationLocation;

  Future<void> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
  }

  Future<LatLng?> _pickLocation() async {
    await _checkPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPickerPage(
          initialPosition: LatLng(position.latitude, position.longitude),
        ),
      ),
    );

    return selectedLocation;
  }

  void selectCurrentLocation() async {
    LatLng? location = await _pickLocation();
    if (location != null) {
      setState(() {
        currentLocation = location;
      });
    }
  }

  void selectDestinationLocation() async {
    LatLng? location = await _pickLocation();
    if (location != null) {
      setState(() {
        destinationLocation = location;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เลือกตำแหน่ง'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: selectCurrentLocation,
              child: Text('เลือกตำแหน่งที่อยู่'),
            ),
            if (currentLocation != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'ตำแหน่งที่อยู่: ${currentLocation!.latitude}, ${currentLocation!.longitude}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectDestinationLocation,
              child: Text('เลือกตำแหน่งที่ต้องการไป'),
            ),
            if (destinationLocation != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'ตำแหน่งที่ต้องการไป: ${destinationLocation!.latitude}, ${destinationLocation!.longitude}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MapPickerPage extends StatefulWidget {
  final LatLng initialPosition;

  const MapPickerPage({Key? key, required this.initialPosition}) : super(key: key);

  @override
  _MapPickerPageState createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  GoogleMapController? mapController;
  LatLng? pickedLocation;

  @override
  void initState() {
    super.initState();
    pickedLocation = widget.initialPosition;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      pickedLocation = position.target;
    });
  }

  void _confirmLocation() {
    Navigator.pop(context, pickedLocation);
  }

  Future<void> _moveToCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      LatLng current = LatLng(position.latitude, position.longitude);
      mapController?.animateCamera(CameraUpdate.newLatLng(current));
      setState(() {
        pickedLocation = current;
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เลือกตำแหน่งบนแผนที่'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: _moveToCurrentLocation,
            tooltip: 'ไปยังตำแหน่งปัจจุบัน',
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: pickedLocation ?? widget.initialPosition,
              zoom: 16,
            ),
            markers: pickedLocation != null
                ? {
                    Marker(
                      markerId: MarkerId('pickedLocation'),
                      position: pickedLocation!,
                    ),
                  }
                : {},
            onCameraMove: _onCameraMove,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
          Center(
            child: Icon(Icons.location_pin, size: 50, color: Colors.red),
          ),
          Positioned(
            bottom: 30,
            left: 50,
            right: 50,
            child: ElevatedButton(
              onPressed: _confirmLocation,
              child: Text('ยืนยันตำแหน่งนี้'),
            ),
          )
        ],
      ),
    );
  }
}
