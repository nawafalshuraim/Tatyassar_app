import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:loom_store/common/widgets/appbar/appbar.dart';

class MapWithCurrentLocationScreen extends StatefulWidget {
  const MapWithCurrentLocationScreen({super.key});

  @override
  _MapWithCurrentLocationScreenState createState() =>
      _MapWithCurrentLocationScreenState();
}

class _MapWithCurrentLocationScreenState
    extends State<MapWithCurrentLocationScreen> {
  GoogleMapController? _mapController;
  LatLng? _markerPosition;
  String _currentAddress = 'Locating...';
  Placemark? _selectedPlacemark;
  bool _isLoadingAddress = false;

  @override
  void initState() {
    super.initState();
    _determinePositionAndAddress();
  }

  Future<void> _determinePositionAndAddress() async {
    setState(() {
      _currentAddress = 'Locating...';
      _isLoadingAddress = true;
    });

    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentAddress = 'Location services are disabled.';
        _isLoadingAddress = false;
      });
      return;
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentAddress = 'Location permissions are denied';
          _isLoadingAddress = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentAddress =
            'Location permissions are permanently denied, cannot request.';
        _isLoadingAddress = false;
      });
      return;
    }

    // Get the current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      LatLng latLng = LatLng(position.latitude, position.longitude);
      await _updateAddressFromLatLng(latLng, moveCamera: true);
    } catch (e) {
      setState(() {
        _currentAddress = 'Failed to get location: $e';
        _isLoadingAddress = false;
      });
    }
  }

  Future<void> _updateAddressFromLatLng(LatLng latLng,
      {bool moveCamera = false}) async {
    setState(() {
      _isLoadingAddress = true;
      _markerPosition = latLng;
    });

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        String formattedAddress =
            '${place.street ?? ''}, ${place.locality ?? ''}, ${place.postalCode ?? ''}, ${place.country ?? ''}';

        setState(() {
          _currentAddress = formattedAddress;
          _selectedPlacemark = place;
          _isLoadingAddress = false;
        });

        if (moveCamera) {
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(latLng, 15),
          );
        }
      }
    } catch (e) {
      setState(() {
        _currentAddress = 'Failed to get address: $e';
        _isLoadingAddress = false;
      });
    }
  }

  void _confirmSelection() {
    if (_selectedPlacemark != null) {
      Get.back(result: _selectedPlacemark);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No location selected to confirm')),
      );
    }
  }

  void _onMapTapped(LatLng position) {
    _updateAddressFromLatLng(position);
  }

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>{};

    if (_markerPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('selected_location'),
          position: _markerPosition!,
          draggable: true,
          onDragStart: (position) {
            setState(() {
              _currentAddress = 'Getting address...';
            });
          },
          onDragEnd: (newPos) async {
            await _updateAddressFromLatLng(newPos, moveCamera: false);
          },
          infoWindow: InfoWindow(
            title: _isLoadingAddress ? 'Getting address...' : _currentAddress,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CAppBar(
        title: const Text('Select Location'),
        centerTitle: true,
        showBackArrow: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _determinePositionAndAddress,
            tooltip: 'Go to current location',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: _markerPosition == null
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Loading your location...'),
                      ],
                    ),
                  )
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _markerPosition!,
                      zoom: 15,
                    ),
                    markers: markers,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    onTap: _onMapTapped,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    compassEnabled: true,
                    mapToolbarEnabled: false,
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: const Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _isLoadingAddress ? 'Getting address...' : _currentAddress,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (_isLoadingAddress) ...[
                  const SizedBox(height: 8),
                  const LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  'Tap on the map or drag the pin to select a different location',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _isLoadingAddress ? null : _confirmSelection,
                    icon: _isLoadingAddress
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(Icons.check, size: 22),
                    label: Text(
                      _isLoadingAddress ? 'Getting Address...' : 'Confirm Location',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
