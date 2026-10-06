// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Photo _$PhotoFromJson(Map<String, dynamic> json) => _Photo(
  id: json['id'] as String,
  observationId: json['observationId'] as String,
  localPath: json['localPath'] as String,
  remoteUrl: json['remoteUrl'] as String?,
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  fileSize: (json['fileSize'] as num).toInt(),
  mimeType: json['mimeType'] as String,
  capturedAt: DateTime.parse(json['capturedAt'] as String),
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  altitude: (json['altitude'] as num?)?.toDouble(),
  gpsAccuracy: (json['gpsAccuracy'] as num?)?.toDouble(),
  deviceId: json['deviceId'] as String?,
  exifData: json['exifData'] as Map<String, dynamic>?,
  status:
      $enumDecodeNullable(_$PhotoStatusEnumMap, json['status']) ??
      PhotoStatus.local,
  uploadedAt: json['uploadedAt'] == null
      ? null
      : DateTime.parse(json['uploadedAt'] as String),
);

Map<String, dynamic> _$PhotoToJson(_Photo instance) => <String, dynamic>{
  'id': instance.id,
  'observationId': instance.observationId,
  'localPath': instance.localPath,
  'remoteUrl': instance.remoteUrl,
  'width': instance.width,
  'height': instance.height,
  'fileSize': instance.fileSize,
  'mimeType': instance.mimeType,
  'capturedAt': instance.capturedAt.toIso8601String(),
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'altitude': instance.altitude,
  'gpsAccuracy': instance.gpsAccuracy,
  'deviceId': instance.deviceId,
  'exifData': instance.exifData,
  'status': _$PhotoStatusEnumMap[instance.status]!,
  'uploadedAt': instance.uploadedAt?.toIso8601String(),
};

const _$PhotoStatusEnumMap = {
  PhotoStatus.local: 'local',
  PhotoStatus.uploading: 'uploading',
  PhotoStatus.uploaded: 'uploaded',
  PhotoStatus.failed: 'failed',
};
