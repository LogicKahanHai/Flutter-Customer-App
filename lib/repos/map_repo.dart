import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pk_customer_app/constants/repo_constants.dart';

class MapRepo {
  static const String _baseUrl = RepoConstants.googleBaseUrl;
  static const String _apiKey = RepoConstants.googleApiKey;

  static String _getRoute(List<dynamic> addressComponent) {
    for (Map<String, dynamic> part in addressComponent) {
      if (part['types'].contains("route")) {
        return part['long_name'] + ' ';
      }
    }
    return '';
  }

  static String _getNeighborhood(List<dynamic> addressComponent) {
    for (Map<String, dynamic> part in addressComponent) {
      if (part['types'].contains("neighborhood")) {
        return part['long_name'] + ' ';
      }
    }
    return '';
  }

  static Future<Map<String, dynamic>> getLocDeetsForMapScreen(
      LatLng latLng) async {
    double lat = double.parse(latLng.latitude.toStringAsFixed(6));
    double lon = double.parse(latLng.longitude.toStringAsFixed(6));

    Map<String, dynamic> locDeets = {
      'short': '',
      'full': '',
      'lat': lat,
      'lon': lon,
      'placeId': '',
    };

    final String url =
        '$_baseUrl/geocode/json?latlng=$lat,$lon&result_type=street_address&key=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (jsonDecode(response.body)['status'] == 'OK') {
      locDeets['short'] = _getRoute(
              jsonDecode(response.body)['results'][0]['address_components']) +
          _getNeighborhood(
              jsonDecode(response.body)['results'][0]['address_components']);
      locDeets['full'] =
          jsonDecode(response.body)['results'][0]['formatted_address'];
      locDeets['placeId'] = jsonDecode(response.body)['results'][0]['place_id'];
      return locDeets;
    } else if (jsonDecode(response.body)['status'] == 'ZERO_RESULTS') {
      locDeets['short'] = 'Unnamed Road';
      locDeets['full'] = 'Unnamed Road';
      return locDeets;
    } else {
      throw Exception('Failed to load location details');
    }
  }

  static Future<List<dynamic>> getLocDeetsForAddressSearch(String query) async {
    const latLng = LatLng(19.0760, 72.8777);
    double lat = double.parse(latLng.latitude.toStringAsFixed(6));
    double lon = double.parse(latLng.longitude.toStringAsFixed(6));

    List<dynamic> result = [];

    final String url =
        '$_baseUrl/place/autocomplete/json?input=${Uri.encodeComponent(query)}&location=$lat%2C$lon&radius=20000&strictbounds=true&key=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (jsonDecode(response.body)['status'] == 'OK') {
      result = jsonDecode(response.body)['predictions'];
      return result;
    } else {
      throw Exception('Failed to load location details');
    }
  }

  static Future<Map<String, dynamic>> getLocDeetsForPlaceId(String selection) {
    final String url =
        '$_baseUrl/place/details/json?place_id=$selection&fields=formatted_address%2Cname%2Cgeometry&key=$_apiKey';

    return http.get(Uri.parse(url)).then((response) {
      if (jsonDecode(response.body)['status'] == 'OK') {
        return {
          'lat': double.parse(jsonDecode(response.body)['result']['geometry']
                  ['location']['lat']
              .toStringAsFixed(6)),
          'lon': double.parse(jsonDecode(response.body)['result']['geometry']
                  ['location']['lng']
              .toStringAsFixed(6)),
          'short': jsonDecode(response.body)['result']['name'],
          'full': jsonDecode(response.body)['result']['formatted_address'],
          'placeId': selection,
        };
      } else {
        throw Exception('Failed to load location details');
      }
    });
  }
}
