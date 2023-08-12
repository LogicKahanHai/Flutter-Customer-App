class MapRepo {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/place/findplacefromtext/json';

  Future<Map<String, dynamic>> getLocDeetsForMapScreen() {
    return Future.delayed(Duration(seconds: 1), () {
      return {
        'formatted_address': 'Bengaluru, Karnataka, India',
        'lat': '12.9715987',
        'lon': '77.5945627',
      };
    });
  }
}
