import 'package:geolocator/geolocator.dart';

class LocationService {
  final GeolocatorPlatform _geo = GeolocatorPlatform.instance;

  Future<void> ensurePermission() async {
    final enabled = await _geo.isLocationServiceEnabled();
    if (!enabled) throw Exception('Location service disabled');

    var permission = await _geo.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geo.requestPermission();
    }

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied');
    }
  }

  Stream<Position> stream() {
    const settings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 5,
    );
    return _geo.getPositionStream(locationSettings: settings);
  }
}
