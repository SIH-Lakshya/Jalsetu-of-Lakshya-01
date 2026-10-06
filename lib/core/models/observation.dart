import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'observation.freezed.dart';
part 'observation.g.dart';

@freezed
abstract class Observation with _$Observation {
  const factory Observation({
    required String id,
    required String watershedId,
    required String userId,
    required ObservationType type,
    required ObservationStatus status,
    required LatLng location,
    required double gpsAccuracy,
    required DateTime timestamp,
    String? notes,
    List<String>? photoIds,
    String? interventionId,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? syncedAt,
  }) = _Observation;

  factory Observation.fromJson(Map<String, dynamic> json) => _$ObservationFromJson(json);
}

enum ObservationType {
  @JsonValue('condition')
  condition,
  @JsonValue('intervention')
  intervention,
  @JsonValue('water_quality')
  waterQuality,
  @JsonValue('vegetation')
  vegetation,
  @JsonValue('soil')
  soil,
  @JsonValue('other')
  other,
}

enum ObservationStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('pending')
  pending,
  @JsonValue('synced')
  synced,
  @JsonValue('failed')
  failed,
  @JsonValue('rejected')
  rejected,
}