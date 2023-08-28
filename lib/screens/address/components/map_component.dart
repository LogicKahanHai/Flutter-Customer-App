// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pk_customer_app/common/blocs/export_blocs.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/repos/repos.dart';
import 'package:pk_customer_app/screens/address/ui/address_form_page.dart';

class MapComponent extends StatefulWidget {
  final LatLng? initialPosition;
  final String? placeId;
  final Map<String, dynamic>? searchLocDeets;
  const MapComponent(
      {Key? key, this.initialPosition, this.placeId, this.searchLocDeets})
      : super(key: key);

  @override
  _MapComponentState createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  late GoogleMapController _controller;
  Map<String, dynamic> locDeets = {};
  bool isLoading = false;
  bool isLocationLoading = false;
  bool isMoving = false;
  bool isFromSearch = false;
  late bool isLocationEnabled;
  late LocationPermission isLocationGranted;
  late ScreenCoordinate screenCoordinate;
  Position? currentPosition;

  Future<dynamic> showErrorDialog(String title, String message) async {
    return await showDialog<bool>(
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
      await showErrorDialog(
        'Location Disabled',
        'Please enable location to continue',
      );
      return false;
    }
    List<dynamic> loc = await GeoRepo.getCurrentLatLong();
    isLocationGranted = loc[0];
    if (isLocationGranted == LocationPermission.deniedForever ||
        isLocationGranted == LocationPermission.denied) {
      await showErrorDialog(
        'Location Permission Denied',
        'Please grant location permission from settings to continue',
      );
      return false;
    }
    try {
      currentPosition = loc[1];
      return true;
    } catch (e) {
      await showErrorDialog(
        'Location Error',
        'Please try again',
      );
      return false;
    }
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
      widget.initialPosition != null
          ? isFromSearch = true
          : isFromSearch = false;
    });
    initStuff().then((value) {
      if (value) {
        _center = widget.initialPosition != null
            ? widget.initialPosition!
            : currentPosition != null
                ? LatLng(currentPosition!.latitude, currentPosition!.longitude)
                : const LatLng(19.0819885, 72.5693366);
        locDeets = widget.searchLocDeets != null ? widget.searchLocDeets! : {};
        setState(() {
          isLoading = false;
        });
      } else {
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  late LatLng _center;

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    screenCoordinate = currentPosition != null
        ? await _controller.getScreenCoordinate(
            LatLng(currentPosition!.latitude, currentPosition!.longitude))
        : await _controller
            .getScreenCoordinate(const LatLng(19.0819885, 72.5693366));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late ScrollController scrollController;

  final userBloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: PKTheme.primaryColor,
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 18,
                  ),
                  mapType: MapType.normal,
                  onCameraMoveStarted: () {
                    setState(() {
                      isMoving = true;
                    });
                    setState(() {
                      isLocationLoading = true;
                    });
                  },
                  onCameraMove: (position) async {
                    _center = position.target;
                  },
                  onCameraIdle: () async {
                    setState(() {
                      isMoving = false;
                    });
                    await Future.delayed(const Duration(milliseconds: 500));
                    if (isMoving) {
                      return;
                    }
                    locDeets = await MapRepo.getLocDeetsForMapScreen(_center);
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
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          // padding:
                          //     const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: PKTheme.primaryColor, width: 2),
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
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 9),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
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
                                      ? const SizedBox(
                                          height: 60,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: PKTheme.primaryColor,
                                            ),
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              locDeets['short'] != null
                                                  ? locDeets['short']! != ''
                                                      ? locDeets['short']!
                                                      : 'Unnamed Road'
                                                  : 'Select a location',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              locDeets['full'] != null
                                                  ? locDeets['full']! != ''
                                                      ? locDeets['full']!
                                                      : 'Unnamed Road'
                                                  : 'Move the map to select a location',
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
                            BlocListener(
                              bloc: userBloc,
                              listener: (context, state) async {
                                if (state is UserAuthState) {
                                  Navigator.pop(context);
                                  Navigator.pop(context, true);
                                } else if (state is UserLoadingState) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const Center(
                                      child: CircularProgressIndicator(
                                        color: PKTheme.primaryColor,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    RouteAnimations(
                                      nextPage: AddressFormPage(
                                        shortAddress: locDeets['short'] != null
                                            ? locDeets['short']! != ''
                                                ? locDeets['short']!
                                                : 'Unnamed Road'
                                            : 'Select a location',
                                        longAddress: locDeets['full'] != null
                                            ? locDeets['full']! != ''
                                                ? locDeets['full']!
                                                : 'Unnamed Road'
                                            : 'Move the map to select a location',
                                      ),
                                      animationDirection:
                                          AnimationDirection.BTT,
                                    ).createRoute(),
                                  ).then((value) async {
                                    if (value != null) {
                                      userBloc.add(UserAddAddressEvent(
                                        placeId: locDeets['placeId']!,
                                        address1: value['house'],
                                        address2: value['apartment'],
                                        addressType: value['saveAs'],
                                        lat: locDeets['lat']!,
                                        lng: locDeets['lon']!,
                                        phone: UserRepo.user.phone,
                                      ));
                                    }
                                  });
                                },
                                child: const Text(
                                  'Confirm Location',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
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
