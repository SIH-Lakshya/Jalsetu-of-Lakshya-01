import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.freezed.dart';
part 'photo.g.dart';

@freezed
abstract class Photo with _$Photo {
  const factory Photo({
    required String id,
    required String observationId,
    required String localPath,
    String? remoteUrl,
    required int width,
    required int height,
    required int fileSize,
    required String mimeType,
    required DateTime capturedAt,
    double? latitude,
    double? longitude,
    double? altitude,
    double? gpsAccuracy,
    String? deviceId,
    Map<String, dynamic>? exifData,
    @Default(PhotoStatus.local) PhotoStatus status,
    DateTime? uploadedAt,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}

enum PhotoStatus {
  @JsonValue('local')
  local,
  @JsonValue('uploading')
  uploading,
  @JsonValue('uploaded')
  uploaded,
  @JsonValue('failed')
  failed,
}