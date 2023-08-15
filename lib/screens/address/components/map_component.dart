// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pk_customer_app/constants/theme.dart';

class MapComponent extends StatefulWidget {
  const MapComponent({Key? key}) : super(key: key);

  @override
  _MapComponentState createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  late GoogleMapController _controller;

  bool isLoading = false;
  bool isLocationLoading = false;
  late bool isLocationEnabled;
  late LocationPermission isLocationGranted;
  Position? currentPosition;

  void showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<bool> initStuff() async {
    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      showErrorDialog(
        'Location Disabled',
        'Please enable location to continue',
      );
      return false;
    }
    isLocationGranted = await Geolocator.checkPermission();
    if (isLocationGranted == LocationPermission.denied) {
      isLocationGranted = await Geolocator.requestPermission();
    }
    if (isLocationGranted == LocationPermission.deniedForever) {
      showErrorDialog(
        'Location Permission Denied',
        'Please grant location permission from settings to continue',
      );
      return false;
    }
    try {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      return true;
    } catch (e) {
      print(e);
      showErrorDialog(
        'Location Error',
        e.toString(),
      );
      return false;
    }
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    initStuff().then((value) {
      if (value) {
        _center = currentPosition != null
            ? LatLng(currentPosition!.latitude, currentPosition!.longitude)
            : const LatLng(19.0760, 72.8777);
        setState(() {
          isLoading = false;
        });
      } else {
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  late final _center;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 12.2,
                  ),
                  mapType: MapType.normal,
                  onCameraMoveStarted: () {
                    setState(() {
                      isLocationLoading = true;
                    });
                  },
                  onCameraIdle: () {
                    setState(() {
                      isLocationLoading = false;
                    });
                  },
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: isLocationLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Select your location',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Move the map to pin your exact location',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Confirm Location',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 2 - 215,
                  left: MediaQuery.of(context).size.width / 2 - 100,
                  child: Center(
                    child: Container(
                      // padding:
                      //     const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: PKTheme.primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          maximumSize: const Size(190, 40),
                        ),
                        onPressed: () {
                          if (currentPosition != null) {
                            _controller.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(currentPosition!.latitude,
                                      currentPosition!.longitude),
                                  zoom: 18,
                                ),
                              ),
                            );
                          } else {
                            if (!isLocationEnabled) {
                              showErrorDialog(
                                'Location Disabled',
                                'Please enable location in settings to continue',
                              );
                            } else if (isLocationGranted ==
                                LocationPermission.denied) {
                              showErrorDialog(
                                'Location Permission Denied',
                                'Please grant location permission from settings to continue',
                              );
                            } else {
                              setState(() async {
                                currentPosition =
                                    await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.best,
                                );
                              });
                            }
                          }
                          // _controller.animateCamera(
                          //   CameraUpdate.newCameraPosition(
                          //     const CameraPosition(
                          //       target: LatLng(19.0760, 72.8777),
                          //       zoom: 14,
                          //     ),
                          //   ),
                          // );
                        },
                        child: const Center(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: PKTheme.primaryColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Use current location',
                                style: TextStyle(
                                  color: PKTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
