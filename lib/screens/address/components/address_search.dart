// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/repos/map_repo.dart';
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
            onTap: () {
              showSearch(context: context, delegate: SearchAddress());
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

class SearchAddress extends SearchDelegate {
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
      List<SuggestionClass>? suggestions;
      MapRepo.getLocDeetsForAddressSearch(query, sessionToken, latLng).then((value) {
        suggestions = value['predictions'].map<SuggestionClass>((prediction) {
          return SuggestionClass(
            placeId: prediction['place_id'],
            title: prediction['description'],
          );
        }).toList();
      });
      return suggestions == null ? const Center(child: CircularProgressIndicator(
        color: PKTheme.primaryColor,
      )) :
        ListView.builder(
        itemCount: suggestions!.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              close(context, suggestions![index].placeId);
            },
            title: Text(suggestions![index].title),
            leading: const Icon(Icons.location_on),
          );
        },
      );
    }
    return Container();
  }
}

class SuggestionClass {
  final String placeId;
  final String title;
  SuggestionClass({required this.placeId, required this.title});
}
