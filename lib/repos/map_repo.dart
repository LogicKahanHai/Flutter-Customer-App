import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class MapRepo {
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api';
  static final String _apiKey = dotenv.env['GOOGLE_MAPS_API']!;

  static const _uuid = Uuid();

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

  static Future<Map<String, String>> getLocDeetsForMapScreen(
      LatLng latLng) async {
    double lat = double.parse(latLng.latitude.toStringAsFixed(6));
    double lon = double.parse(latLng.longitude.toStringAsFixed(6));

    Map<String, String> locDeets = {
      'short': '',
      'full': '',
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
      return locDeets;
    } else if (jsonDecode(response.body)['status'] == 'ZERO_RESULTS') {
      locDeets['short'] = 'Unnamed Road';
      locDeets['full'] = 'Unnamed Road';
      return locDeets;
    } else {
      print(jsonDecode(response.body)['status']);
      throw Exception('Failed to load location details');
    }
  }

  static Future<List<dynamic>> getLocDeetsForAddressSearch(String query) async {
    const latLng = LatLng(19.0760, 72.8777);
    double lat = double.parse(latLng.latitude.toStringAsFixed(6));
    double lon = double.parse(latLng.longitude.toStringAsFixed(6));

    List<dynamic> result = [];


    //FIXME: I am only getting 1 result. I need to get more results and display them in a list.
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

  static Future<Map<String, String>> getLocDeetsForPlaceId(String selection) {
    final String url =
        '$_baseUrl/place/details/json?place_id=$selection&fields=formatted_address%2Cname%2Cgeometry&key=$_apiKey';

    Map<String, String> locDeets = {
      'lat': '',
      'lon': '',
      'short': '',
      'full': '',
    };

    return http.get(Uri.parse(url)).then((response) {
      if (jsonDecode(response.body)['status'] == 'OK') {
        print(jsonDecode(response.body)['result']);
        return {
          'lat': jsonDecode(response.body)['result']['geometry']['location']
              ['lat'].toStringAsFixed(6),
          'lon': jsonDecode(response.body)['result']['geometry']['location']
              ['lng'].toStringAsFixed(6),
          'short': jsonDecode(response.body)['result']['name'],
          'full': jsonDecode(response.body)['result']['formatted_address'],
        };
      } else {
        throw Exception('Failed to load location details');
      }
    });
    }
  }
