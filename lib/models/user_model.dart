// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'user_address_model.dart';

class UserModel {
  final String id;
  final String token;
  final String phone;
  String? firstName;
  String? lastName;
  List<AddressModel> addresses;
  int currentAddressIndex;
  UserModel({
    required this.id,
    required this.token,
    required this.phone,
    this.firstName,
    this.lastName,
    this.addresses = const [],
    this.currentAddressIndex = 0,
  });

  UserModel.fromJson(Map<String, dynamic> map)
      : phone = map['phone'] as String,
        addresses = (map['addresses'] as List<dynamic>)
            .map((e) => AddressModel.fromJson(
                e as Map<String, dynamic>, map['id'] as String))
            .toList(),
        token = map['token'] as String,
        currentAddressIndex = map['currentAddressIndex'] as int,
        id = map['id'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'phone': phone,
        'token': token,
        'first_name': firstName,
        'last_name': lastName,
        'addresses': addresses.map((e) => e.toJson()).toList(),
        'currentAddressIndex': currentAddressIndex,
      };

  UserModel.fromLogin(this.phone, this.token, this.id)
      : addresses = [],
        currentAddressIndex = 0;
}
