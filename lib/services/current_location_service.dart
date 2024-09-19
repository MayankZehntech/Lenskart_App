import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return null
      print('Location services are disabled.');
      return null;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission denied.');
        // Permissions are denied, return null
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, return null
      print('Location permissions are permanently denied.');
      return null;
    }

    // If permission is granted, get the current position with updated LocationSettings
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high, // Specify high accuracy
      ),
    );
  }

  Future<String> getCityFromCoordinates(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemarks.first.subLocality ?? 'Unknown City';
  }

  // Future<String?> getCityFromCoordinates(Position position) async {
  //   try {
  //     // Convert coordinates to addresses
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );
  //     if (placemarks.isNotEmpty) {
  //       Placemark placemark = placemarks.first;
  //       return placemark.locality; // Returns the city name
  //     }
  //   } catch (e) {
  //     print('Error fetching city name: $e');
  //   }
  //   return null;
  // }
}
