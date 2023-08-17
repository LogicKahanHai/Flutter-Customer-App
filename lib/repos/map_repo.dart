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
    } else {
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
        '$_baseUrl/place/findplacefromtext/json?fields=formatted_address%2Cname%2Cgeometry%2Cplace_id&input=${Uri.encodeComponent(query)}&inputtype=textquery&locationbias=circle%3A20000%40$lat%2C$lon&key=$_apiKey';

    final response = await http.get(Uri.parse(url));


    if (jsonDecode(response.body)['status'] == 'OK') {
      result = jsonDecode(response.body)['candidates'];
      return result;
    } else {
      throw Exception('Failed to load location details');
    }
  }

  static Future<LatLng> getLocDeetsForPlaceId(String selection) {
    final String url =
        '$_baseUrl/place/details/json?place_id=$selection&fields=geometry&key=$_apiKey';

    return http.get(Uri.parse(url)).then((response) {
      if (jsonDecode(response.body)['status'] == 'OK') {
        return LatLng(
          jsonDecode(response.body)['result']['geometry']['location']['lat'],
          jsonDecode(response.body)['result']['geometry']['location']['lng'],
        );
      } else {
        throw Exception('Failed to load location details');
      }
    });
    }
  }
