import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  static Future<http.Response> _sendRequest(String apiCall, Map body) async {
    final response = await http.post(
      Uri.parse(apiCall),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );
    return response;
  }

  static final String _baseUrl = dotenv.env['BASE_API_URL']!;
  static Future<List<dynamic>> sendOtp(String phone) async {
    var apiCall = '$_baseUrl/ms/customer/mobile/auth/login';
    final body = {"method": "otp", "phone": "91$phone"};
    try {
      final response = await _sendRequest(apiCall, body);
      if (response.statusCode == 200) {
        return [true, jsonDecode(response.body)['rid']];
      } else {
        return [false];
      }
    } catch (_) {
      return [false];
    }
  }

  static Future<List<dynamic>> verifyOtp(
      String phone, String rid, String otp) async {
    String apiCall = '$_baseUrl/ms/customer/mobile/auth/login/otp/confirm';
    final body = {"otp": otp, "rid": rid};
    try {
      final response = await _sendRequest(apiCall, body);
      if (response.statusCode == 200 &&
          jsonDecode(response.body)['status'] == "success" &&
          jsonDecode(response.body)['uid'] != null &&
          jsonDecode(response.body)['token'] != null) {
        return [
          true,
          jsonDecode(response.body)['uid'],
          jsonDecode(response.body)['token']
        ];
      } else {
        return [false];
      }
    } catch (_) {
      return [false];
    }
  }
}
