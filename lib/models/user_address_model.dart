// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressModel {
  final String id;
  String line1;
  String placeId;
  String userId;
  String addressName;
  String city;
  String state;
  String country;
  final double lat;
  final double lng;
  num phone;
  String? line2;
  num postcode;

  AddressModel({
    required this.id,
    required this.line1,
    required this.placeId,
    required this.userId,
    required this.addressName,
    required this.city,
    required this.state,
    required this.country,
    required this.lat,
    required this.lng,
    required this.phone,
    required this.postcode,
    this.line2,
  });

  AddressModel.fromJson(Map<String, dynamic> json, String uid)
      : line1 = json['line_1'] as String,
        id = json['_id'] as String,
        userId = json['uid']['_id'] ?? uid,
        addressName = json['tag'] as String? ?? "Other",
        lat = json['lat'] as double,
        lng = json['lng'] as double,
        placeId = json['google_placeID'] as String,
        postcode = json['postcode'] as num,
        city = json['city'] as String,
        state = json['state'] as String,
        country = json['country'] as String,
        phone = json['phone'] as num,
        line2 = json['line_2'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': userId,
        'tag': addressName,
        'line_1': line1,
        'line_2': line2,
        'city': city,
        'state': state,
        'country': country,
        'lat': lat,
        'lng': lng,
        'phone': phone,
        'postcode': postcode,
        'google_placeID': placeId,
      };

  Map<String, dynamic> toCreateAddress() => {
        "lat": lat,
        "lng": lng,
        "place_id": placeId,
        "line_1": line1,
        "line_2": line2 ?? "",
        "postcode": postcode,
        "city": city,
        "state": state,
        "country": country,
        "phone": phone,
      };
}
