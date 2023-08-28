import 'package:geolocator/geolocator.dart';

class GeoRepo {
  static Future<List<dynamic>> getCurrentLatLong() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return [permission, null];
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return [permission, null];
      }
      return [
        permission,
        await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        )
      ];
    }
    return [
      permission,
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      )
    ];
  }
}
