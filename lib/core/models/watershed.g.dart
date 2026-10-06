// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watershed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Watershed _$WatershedFromJson(Map<String, dynamic> json) => _Watershed(
  id: json['id'] as String,
  name: json['name'] as String,
  code: json['code'] as String,
  description: json['description'] as String,
  center: LatLng.fromJson(json['center'] as Map<String, dynamic>),
  areaKm2: (json['areaKm2'] as num).toDouble(),
  state: json['state'] as String,
  district: json['district'] as String,
  programIds: (json['programIds'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$WatershedToJson(_Watershed instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'center': instance.center,
      'areaKm2': instance.areaKm2,
      'state': instance.state,
      'district': instance.district,
      'programIds': instance.programIds,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_WatershedBoundary _$WatershedBoundaryFromJson(Map<String, dynamic> json) =>
    _WatershedBoundary(
      watershedId: json['watershedId'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => LatLng.fromJson(e as Map<String, dynamic>))
          .toList(),
      geometryType: json['geometryType'] as String,
    );

Map<String, dynamic> _$WatershedBoundaryToJson(_WatershedBoundary instance) =>
    <String, dynamic>{
      'watershedId': instance.watershedId,
      'coordinates': instance.coordinates,
      'geometryType': instance.geometryType,
    };
