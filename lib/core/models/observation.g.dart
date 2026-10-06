// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'observation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Observation _$ObservationFromJson(Map<String, dynamic> json) => _Observation(
  id: json['id'] as String,
  watershedId: json['watershedId'] as String,
  userId: json['userId'] as String,
  type: $enumDecode(_$ObservationTypeEnumMap, json['type']),
  status: $enumDecode(_$ObservationStatusEnumMap, json['status']),
  location: LatLng.fromJson(json['location'] as Map<String, dynamic>),
  gpsAccuracy: (json['gpsAccuracy'] as num).toDouble(),
  timestamp: DateTime.parse(json['timestamp'] as String),
  notes: json['notes'] as String?,
  photoIds: (json['photoIds'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  interventionId: json['interventionId'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  syncedAt: json['syncedAt'] == null
      ? null
      : DateTime.parse(json['syncedAt'] as String),
);

Map<String, dynamic> _$ObservationToJson(_Observation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'watershedId': instance.watershedId,
      'userId': instance.userId,
      'type': _$ObservationTypeEnumMap[instance.type]!,
      'status': _$ObservationStatusEnumMap[instance.status]!,
      'location': instance.location,
      'gpsAccuracy': instance.gpsAccuracy,
      'timestamp': instance.timestamp.toIso8601String(),
      'notes': instance.notes,
      'photoIds': instance.photoIds,
      'interventionId': instance.interventionId,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
    };

const _$ObservationTypeEnumMap = {
  ObservationType.condition: 'condition',
  ObservationType.intervention: 'intervention',
  ObservationType.waterQuality: 'water_quality',
  ObservationType.vegetation: 'vegetation',
  ObservationType.soil: 'soil',
  ObservationType.other: 'other',
};

const _$ObservationStatusEnumMap = {
  ObservationStatus.draft: 'draft',
  ObservationStatus.pending: 'pending',
  ObservationStatus.synced: 'synced',
  ObservationStatus.failed: 'failed',
  ObservationStatus.rejected: 'rejected',
};
