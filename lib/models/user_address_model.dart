// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressModel {
  String id;
  String addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? addressType;
  String userId;
  String lat;
  String lon;

  AddressModel({
    required this.id,
    required this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.addressType,
    required this.userId,
    required this.lat,
    required this.lon,
  });

  AddressModel.fromJson(Map<String, dynamic> json)
      : addressLine1 = json['addressLine1'] as String,
        id = json['id'] as String,
        userId = json['userId'] as String,
        addressType = json['addressType'] as String,
        lat = json['lat'] as String,
        lon = json['lon'] as String,
        pincode = json['pincode'],
        addressLine2 = json['addressLine2'],
        city = json['city'],
        state = json['state'],
        country = json['country'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'pincode': pincode,
        'userId': userId,
        'addressType': addressType,
        'city': city,
        'state': state,
        'country': country,
        'lat': lat,
        'lon': lon,
      };
}
