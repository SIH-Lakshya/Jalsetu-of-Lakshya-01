import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'watershed.freezed.dart';
part 'watershed.g.dart';

@freezed
abstract class Watershed with _$Watershed {
  const factory Watershed({
    required String id,
    required String name,
    required String code,
    required String description,
    required LatLng center,
    required double areaKm2,
    required String state,
    required String district,
    List<String>? programIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Watershed;

  factory Watershed.fromJson(Map<String, dynamic> json) => _$WatershedFromJson(json);
}

@freezed
abstract class WatershedBoundary with _$WatershedBoundary {
  const factory WatershedBoundary({
    required String watershedId,
    required List<LatLng> coordinates,
    required String geometryType,
  }) = _WatershedBoundary;

  factory WatershedBoundary.fromJson(Map<String, dynamic> json) => _$WatershedBoundaryFromJson(json);
}