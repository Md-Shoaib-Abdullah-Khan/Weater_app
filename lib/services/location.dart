import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitute;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Service denied");
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Permission denied!");
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print("Permission denied forever!");
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitute = position.longitude;
  }
}
