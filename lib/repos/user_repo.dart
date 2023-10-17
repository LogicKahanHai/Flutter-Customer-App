import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:pk_customer_app/constants/repo_constants.dart';
import 'package:pk_customer_app/models/models.dart';

class UserRepo {
  static late UserModel _user;

  //TODO: Make this Available as a constant throughout the project.
  static const String _baseUrl = RepoConstants.baseUrl;

  UserRepo(UserModel user) {
    _user = user;
  }

  static UserModel get user => _user;
  static String get token => _user.token;

  static set setUser(UserModel newUser) {
    _user = newUser;
  }

  static Future<bool> addAddress({
    required line1,
    line2,
    required placeId,
    required addressName,
    required double lat,
    required double lng,
    required phone,
  }) async {
    final tempResponse = await setTemporaryAddress(Position.fromMap({
      'latitude': lat,
      'longitude': lng,
    }));
    if (tempResponse[0] == false) {
      return false;
    }
    final city = tempResponse[1]['city'];
    final state = tempResponse[1]['state'];
    final country = tempResponse[1]['country'];
    final postcode = tempResponse[1]['postcode'];

    const String apiCall = '$_baseUrl/ms/customer/mobile/address/createAddress';
    final body = {
      "lat": lat,
      "lng": lng,
      "place_id": placeId,
      "line_1": line1,
      "line_2": line2,
      "postcode": postcode,
      "city": city,
      "state": state,
      "country": country,
      "phone": phone,
      "tag": addressName,
    };
    try {
      final response = await RepoConstants.sendRequest(
          apiCall, body, null, RequestType.post);
      if (jsonDecode(response.body)['statusCode'] == 200) {
        final newAddress =
            AddressModel.fromJson(jsonDecode(response.body)['data'], _user.id);
        _user.addresses.add(newAddress);
        _user.addresses = _user.addresses.toSet().toList();
        setCurrentAddressIndex(index: _user.addresses.length - 1);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removeAddress(String id) async {
    final String apiCall =
        '$_baseUrl/ms/customer/mobile/address/deleteAddress/$id';
    final response = await RepoConstants.sendRequest(
        apiCall, null, null, RequestType.delete);
    if (jsonDecode(response.body)['statusCode'] == 200) {
      _user.addresses.removeWhere((element) => element.id == id);
      _user.addresses = _user.addresses.toSet().toList();
      setCurrentAddressIndex(index: 0);
      return true;
    }
    return false;
  }

  static int get addressesLength => _user.addresses.length;

  static List<AddressModel>? get addresses {
    try {
      return _user.addresses;
    } catch (_) {
      return null;
    }
  }

  static Future<bool> getAndSetAddresses() async {
    const String apiCall = '$_baseUrl/ms/customer/mobile/address/getAddress';
    try {
      final response =
          await RepoConstants.sendRequest(apiCall, null, null, RequestType.get);
      if (jsonDecode(response.body)['statusCode'] == 200) {
        final List<dynamic> addresses = jsonDecode(response.body)['data'];
        final List<AddressModel> newAddresses = [];
        for (final address in addresses) {
          newAddresses.add(AddressModel.fromJson(address, _user.id));
        }
        setAddresses(newAddresses);
        setCurrentAddressIndex(index: addressesLength - 1);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static void setAddresses(List<AddressModel> addresses) {
    _user.addresses.clear();
    _user.addresses = addresses;
  }

  static AddressModel? get currentAddress {
    try {
      return _user.addresses[_user.currentAddressIndex];
    } catch (_) {
      return null;
    }
  }

  static Future<List<dynamic>> updateProfile(
      String firstName, String lastName) async {
    const String apiCall = '$_baseUrl/ms/customer/mobile/profile/updateProfile';
    final body = {
      "first_name": firstName,
      "last_name": lastName,
    };
    final response =
        await RepoConstants.sendRequest(apiCall, body, null, RequestType.put);
    if (jsonDecode(response.body)['statusCode'] == 200) {
      final profile = jsonDecode(response.body)['data'];
      if (profile == null) {
        return [false];
      }
      UserModel newUser = user;
      newUser.firstName = firstName;
      newUser.lastName = lastName;
      setUser = newUser;
      return [true, newUser];
    } else {
      return [false];
    }
  }

  static Future<List<dynamic>> profileExists() async {
    const apiCall = '$_baseUrl/ms/customer/mobile/profile/getProfile';
    final response =
        await RepoConstants.sendRequest(apiCall, null, null, RequestType.get);
    if (jsonDecode(response.body)['statusCode'] == 200) {
      final Map<String, dynamic>? profile = jsonDecode(response.body)['data'];
      if (profile == null) {
        return [false];
      }
      UserModel newUser = user;
      newUser.firstName = profile['first_name'];
      newUser.lastName = profile['last_name'];
      setUser = newUser;
      print('newUser set');
      return [true, newUser];
    } else {
      return [false];
    }
  }

  static void setCurrentAddressIndex({int? index, String? id}) async {
    if (index == null) {
      _user.currentAddressIndex =
          _user.addresses.indexWhere((element) => element.id == id);
    } else {
      _user.currentAddressIndex = index;
    }
    await setTemporaryAddress(Position.fromMap({
      'latitude': currentAddress!.lat,
      'longitude': currentAddress!.lng,
    }));
  }

  static Future<List<dynamic>> setTemporaryAddress(Position position) async {
    const String apiCall =
        '$_baseUrl/ms/customer/mobile/address/tempAddressCreate';
    final body = {
      "lat": position.latitude.toStringAsFixed(6),
      "lng": position.longitude.toStringAsFixed(6),
    };
    final response =
        await RepoConstants.sendRequest(apiCall, body, null, RequestType.post);
    if (jsonDecode(response.body)['statusCode'] == 200) {
      return [true, jsonDecode(response.body)['data']];
    }
    return [false, jsonDecode(response.body)['error']];
  }

  static Future<bool> updateAddress({
    required String id,
    required placeId,
    required String line1,
    required String addressName,
    required double lat,
    required double lng,
    required String line2,
    required String phone,
  }) async {
    const String apiCall = '$_baseUrl/ms/customer/mobile/address/updateAddress';
    final body = {
      "id": id,
      "lat": lat,
      "lng": lng,
      "place_id": placeId,
      "line_1": line1,
      "line_2": line2,
      "phone": phone,
      "tag": addressName,
    };
    final response =
        await RepoConstants.sendRequest(apiCall, body, null, RequestType.put);
    if (jsonDecode(response.body)['statusCode'] == 200 &&
        jsonDecode(response.body)['data']['matchedCount'] == 1) {
      await getAndSetAddresses();
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> getUser() async {
    print('getUser called');
    const String apiCall = '$_baseUrl/ms/customer/mobile/placeOrder/';
    late final http.Response response;
    print('getUser calling');
    try {
      response =
          await RepoConstants.sendRequest(apiCall, null, null, RequestType.get);
    } catch (e) {
      print('getUser failed');
      return false;
    }

    if (jsonDecode(response.body)['statusCode'] == 200) {
      final Map<String, dynamic>? orderJson = jsonDecode(response.body)['data'];
      if (orderJson == null) {
        print('orderJson is null');
        return false;
      }
      UserModel newUser = user;
      user.pastOrders = [];
      for (final order in orderJson['orders']) {
        user.pastOrders!.add(OrderModel.fromJson(order));
      }
      setUser = newUser;
      print('newUser set');
      return true;
    } else {
      print('getUser failed');
      return false;
    }
  }
}
