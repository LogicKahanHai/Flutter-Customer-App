class AddressModel {
  String id;
  String address;
  String? city;
  String? state;
  String? country;
  String pincode;
  String? addressType;
  String userId;
  String? lat;
  String? lon;

  AddressModel({
    required this.id,
    required this.address,
    this.city,
    this.state,
    this.country,
    required this.pincode,
    this.addressType,
    required this.userId,
    this.lat,
    this.lon,
  });

  AddressModel.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        id = json['id'] as String,
        pincode = json['pincode'] as String,
        userId = json['userId'] as String,
        addressType = json['addressType'],
        city = json['city'],
        state = json['state'],
        country = json['country'],
        lat = json['lat'],
        lon = json['lon'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
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
