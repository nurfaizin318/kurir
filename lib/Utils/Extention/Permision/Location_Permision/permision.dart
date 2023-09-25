import 'package:geolocator/geolocator.dart';

class PermissionToUser {
  static Future permissionForLocation() async {
    final request = Geolocator.requestPermission();

    if (LocationPermission.denied == true) {
      request;
      return false;
    } else if (LocationPermission.deniedForever == true) {
      request;
      return false;
    } else if (LocationPermission.unableToDetermine == true) {
      request;
      return false;
    } else {
      return true;
    }
  }

  static Future<Position>? determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
