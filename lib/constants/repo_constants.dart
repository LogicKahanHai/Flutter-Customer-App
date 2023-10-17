import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pk_customer_app/repos/repos.dart';

enum RequestType { get, post, delete, put }

class RepoConstants {
  static const String baseUrl = "https://flexy-aws.coyogi.com";
  static const String googleBaseUrl = 'https://maps.googleapis.com/maps/api';
  static const String googleApiKey = 'AIzaSyC-nQ1t--VdXbuOX06O_dGQAWiAtChVsdc';
  static const String codPaymentMethodId = 'cod';
  static const String razorpayPaymentMethodId = 'razorpay';

  static Future<http.Response> sendRequest(String apiCall, Map? body,
      Map<String, String>? headers, RequestType requestType) async {
    Map<String, String> defaultHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${UserRepo.token}',
    };
    switch (requestType) {
      case RequestType.get:
        print('GET: $apiCall');
        try {
          final response = await http.get(
            Uri.parse(apiCall),
            headers: headers ?? defaultHeader,
          );
          print('Response: ${response.body}');
          return response;
        } catch (e) {
          print(e);
          return http.Response('{"error": "Something went wrong"}', 500);
        }
      case RequestType.post:
        return await http.post(
          Uri.parse(apiCall),
          headers: headers ?? defaultHeader,
          body: json.encode(body),
        );
      case RequestType.delete:
        return await http.delete(
          Uri.parse(apiCall),
          headers: headers ?? defaultHeader,
        );
      case RequestType.put:
        return await http.put(
          Uri.parse(apiCall),
          headers: headers ?? defaultHeader,
          body: json.encode(body),
        );
    }
  }
}
