import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import '../utils/constants.dart';

part 'location_service.g.dart';

@riverpod
LocationService locationService(Ref ref) {
  return LocationService();
}

class LocationService {
  Future<bool> requestPermission() async {
    final status = await permission_handler.Permission.location.request();
    return status.isGranted;
  }

  Future<bool> isPermissionGranted() async {
    final status = await permission_handler.Permission.location.status;
    return status.isGranted;
  }

  Future<Position> getCurrentPosition({
    LocationAccuracy accuracy = LocationAccuracy.high,
    Duration? timeLimit,
  }) async {
    final hasPermission = await requestPermission();
    if (!hasPermission) {
      throw Exception('Location permission denied');
    }

    return Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        timeLimit: timeLimit ?? const Duration(seconds: 10),
      ),
    );
  }

  Future<Position?> getLastKnownPosition() async {
    return Geolocator.getLastKnownPosition();
  }

  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilterMeters = 10,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilterMeters,
      ),
    );
  }

  bool isAccuracyAcceptable(double accuracy) {
    return accuracy <= minGpsAccuracy;
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  Future<void> openAppSettings() async {
    await permission_handler.openAppSettings();
  }
}