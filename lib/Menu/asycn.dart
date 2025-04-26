// Menu/asycn.dart
// Add this import at the top of the file
import 'dart:async';

// Define the LocationSearchResult class
class LocationSearchResult {
  final String placeName;
  final String address;
  final LatLng position;

  LocationSearchResult({
    required this.placeName,
    required this.address,
    required this.position,
  });
}

// Complete the _LocationPickerScreenState class
class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late GoogleMapController _mapController;
  LatLng _selectedPosition = const LatLng(17.9757, 102.6331); // Default position in Vientiane
  String _selectedAddress = 'ກຳລັງຄົ້ນຫາທີ່ຢູ່...';
  final TextEditingController _searchController = TextEditingController();
  List<LocationSearchResult> _searchResults = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _selectedPosition = widget.initialLocation!.position;
      _selectedAddress = widget.initialLocation!.address;
    } else {
      _getCurrentLocation();
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    final loc.Location location = loc.Location();
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      loc.PermissionStatus permissionStatus = await location.hasPermission();
      if (permissionStatus == loc.PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();
        if (permissionStatus != loc.PermissionStatus.granted) {
          return;
        }
      }

      final locationData = await location.getLocation();
      setState(() {
        _selectedPosition = LatLng(locationData.latitude!, locationData.longitude!);
      });
      
      _moveToPosition(_selectedPosition);
      _getAddressFromLatLng(_selectedPosition);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ບໍ່ສາມາດດຶງຕຳແໜ່ງໄດ້: $e')),
        );
      }
    }
  }

  // Add the missing _moveToPosition method
  void _moveToPosition(LatLng position) {
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
  }

  // Complete the _getAddressFromLatLng method
  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        setState(() {
          _selectedAddress = '${placemark.street ?? ""}, ${placemark.subLocality ?? ""}, ${placemark.locality ?? ""}';
          if (_selectedAddress.trim().isEmpty || _selectedAddress.trim() == ',,') {
            _selectedAddress = 'ຕຳແໜ່ງທີ່ບໍ່ຮູ້ຈັກ';
          }
        });
      }
    } catch (e) {
      setState(() {
        _selectedAddress = 'ບໍ່ສາມາດລະບຸທີ່ຢູ່ໄດ້';
      });
    }
  }

  // Add the missing search functionality
  void _searchPlaces(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        setState(() {
          _searchResults = [];
        });
        return;
      }
      
      try {
        // This is a placeholder. In a real app, you would use a geocoding API
        // like Google Places API to search for places
        List<LocationSearchResult> results = [];
        
        // For now, just add a dummy result for demonstration
        results.add(
          LocationSearchResult(
            placeName: 'ສະຖານທີ່ຄົ້ນຫາ: $query',
            address: 'ຕົວຢ່າງທີ່ຢູ່ສຳລັບ $query',
            position: const LatLng(17.9757, 102.6331),
          ),
        );
        
        setState(() {
          _searchResults = results;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ເກີດຂໍ້ຜິດພາດໃນການຄົ້ນຫາ: $e')),
        );
      }
    });
  }

  // Complete the build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ເລືອກຕຳແໜ່ງ'),
        backgroundColor: Colors.teal[700],
      ),
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedPosition,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onTap: (LatLng position) {
              setState(() {
                _selectedPosition = position;
              });
              _getAddressFromLatLng(position);
            },
            markers: {
              Marker(
                markerId: const MarkerId('selectedLocation'),
                position: _selectedPosition,
                draggable: true,
                onDragEnd: (newPosition) {
                  setState(() {
                    _selectedPosition = newPosition;
                  });
                  _getAddressFromLatLng(newPosition);
                },
              ),
            },
          ),
          
          // Search bar at the top
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'ຄົ້ນຫາສະຖານທີ່',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.teal[700]),
                ),
                onChanged: _searchPlaces,
              ),
            ),
          ),
          
          // Search results
          if (_searchResults.isNotEmpty)
            Positioned(
              top: 60,
              left: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final result = _searchResults[index];
                    return ListTile(
                      title: Text(result.placeName),
                      subtitle: Text(result.address),
                      onTap: () {
                        setState(() {
                          _selectedPosition = result.position;
                          _selectedAddress = result.address;
                          _searchResults = [];
                          _searchController.clear();
                        });
                        _moveToPosition(_selectedPosition);
                      },
                    );
                  },
                ),
              ),
            ),
          
          // Selected address and confirmation button at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ທີ່ຢູ່ທີ່ເລືອກ:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.teal[700],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _selectedAddress,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'ພິກັດ: ${_selectedPosition.latitude.toStringAsFixed(6)}, ${_selectedPosition.longitude.toStringAsFixed(6)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Return the selected location to the previous screen
                        Navigator.pop(
                          context,
                          MyLocationData(
                            position: _selectedPosition,
                            address: _selectedAddress,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[700],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'ຢືນຢັນຕຳແໜ່ງນີ້',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Current location button
          Positioned(
            bottom: 160,
            right: 10,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: _getCurrentLocation,
              child: Icon(
                Icons.my_location,
                color: Colors.teal[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}