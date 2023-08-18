// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/repos/map_repo.dart';
import 'package:pk_customer_app/screens/address/components/components_address.dart';
import 'package:pk_customer_app/screens/address/ui/address_map_page.dart';
import 'package:uuid/uuid.dart';

class AddressSearch extends StatefulWidget {
  const AddressSearch({Key? key}) : super(key: key);

  @override
  _AddressSearchState createState() => _AddressSearchState();
}

class _AddressSearchState extends State<AddressSearch> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              String? selection = await showSearch<String?>(context: context, delegate: SearchAddress());
              if(selection != null) {
                await MapRepo.getLocDeetsForPlaceId(selection).then((value) {
                  Navigator.push(
                      context,
                      RouteAnimations(
                        nextPage: AddressMapPage(initialPosition: LatLng(double.parse(value['lat']!), double.parse(value['lon']!)), placeId: selection),
                        animationDirection: AnimationDirection.leftToRight,
                      ).createRoute());
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 72,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 1.5,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.search, color: Colors.grey.shade600, size: 30),
                  const SizedBox(width: 10),
                  const Text(
                    'Try Prime Plaza, CBD Belapur etc..',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  RouteAnimations(
                    nextPage: const AddressMapPage(),
                    animationDirection: AnimationDirection.leftToRight,
                  ).createRoute());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: PKTheme.primaryColor, size: 30),
                      SizedBox(width: 10),
                      Text(
                        'Use current location',
                        style: TextStyle(
                          color: PKTheme.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchAddress extends SearchDelegate<String?> {
  SearchAddress({String? hintText, this.latLng})
      : super(
          searchFieldLabel: hintText ?? 'Try Prime Plaza, CBD Belapur etc..',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          searchFieldStyle: const TextStyle(
            color: Colors.grey,
          ),
        );

  String? sessionToken;
  LatLng? latLng;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    sessionToken ??= const Uuid().v4();
    if(query.isNotEmpty && query.length >= 3) {
      return FutureBuilder<List<SuggestionClass>>(
        future: getSuggestions(query),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      close(context, snapshot.data![index].placeId);
                    },
                    title: Text(
                      snapshot.data![index].title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      snapshot.data![index].subtitle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    leading: const Icon(
                      Icons.location_on,
                      color: PKTheme.primaryColor,
                      size: 30,
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator(
            color: PKTheme.primaryColor,
            strokeWidth: 3,
          ));
        },
      );
    }
    return Container();
  }

  Future<List<SuggestionClass>> getSuggestions(String query) async {
    List<dynamic> result = [];
    try {
      result = await MapRepo.getLocDeetsForAddressSearch(query);
    } catch(_) {
    }

    List<SuggestionClass> suggestions = [];
    try {
      for(var place in result) {
        suggestions.add(SuggestionClass(
          placeId: place['place_id'],
          title: place['structured_formatting']['main_text'],
          subtitle: place['structured_formatting']['main_text'] + ', ' + place['structured_formatting']['secondary_text'],
        ));
      }
    } catch (_) {
    }
    return suggestions;
  }

}

class SuggestionClass {
  final String placeId;
  final String title;
  final String subtitle;
  SuggestionClass({required this.subtitle, required this.placeId, required this.title});
}
