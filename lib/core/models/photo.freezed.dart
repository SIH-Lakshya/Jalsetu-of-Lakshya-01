// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Photo {

 String get id; String get observationId; String get localPath; String? get remoteUrl; int get width; int get height; int get fileSize; String get mimeType; DateTime get capturedAt; double? get latitude; double? get longitude; double? get altitude; double? get gpsAccuracy; String? get deviceId; Map<String, dynamic>? get exifData; PhotoStatus get status; DateTime? get uploadedAt;
/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhotoCopyWith<Photo> get copyWith => _$PhotoCopyWithImpl<Photo>(this as Photo, _$identity);

  /// Serializes this Photo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Photo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Photo&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.observationId, _this.observationId) || other.observationId == _this.observationId)&&(identical(other.localPath, _this.localPath) || other.localPath == _this.localPath)&&(identical(other.remoteUrl, _this.remoteUrl) || other.remoteUrl == _this.remoteUrl)&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.height, _this.height) || other.height == _this.height)&&(identical(other.fileSize, _this.fileSize) || other.fileSize == _this.fileSize)&&(identical(other.mimeType, _this.mimeType) || other.mimeType == _this.mimeType)&&(identical(other.capturedAt, _this.capturedAt) || other.capturedAt == _this.capturedAt)&&(identical(other.latitude, _this.latitude) || other.latitude == _this.latitude)&&(identical(other.longitude, _this.longitude) || other.longitude == _this.longitude)&&(identical(other.altitude, _this.altitude) || other.altitude == _this.altitude)&&(identical(other.gpsAccuracy, _this.gpsAccuracy) || other.gpsAccuracy == _this.gpsAccuracy)&&(identical(other.deviceId, _this.deviceId) || other.deviceId == _this.deviceId)&&const DeepCollectionEquality().equals(other.exifData, _this.exifData)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.uploadedAt, _this.uploadedAt) || other.uploadedAt == _this.uploadedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Photo;
  return Object.hash(runtimeType,_this.id,_this.observationId,_this.localPath,_this.remoteUrl,_this.width,_this.height,_this.fileSize,_this.mimeType,_this.capturedAt,_this.latitude,_this.longitude,_this.altitude,_this.gpsAccuracy,_this.deviceId,const DeepCollectionEquality().hash(_this.exifData),_this.status,_this.uploadedAt);
}

@override
String toString() {
  final _this = this as Photo;
  return 'Photo(id: ${_this.id}, observationId: ${_this.observationId}, localPath: ${_this.localPath}, remoteUrl: ${_this.remoteUrl}, width: ${_this.width}, height: ${_this.height}, fileSize: ${_this.fileSize}, mimeType: ${_this.mimeType}, capturedAt: ${_this.capturedAt}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, altitude: ${_this.altitude}, gpsAccuracy: ${_this.gpsAccuracy}, deviceId: ${_this.deviceId}, exifData: ${_this.exifData}, status: ${_this.status}, uploadedAt: ${_this.uploadedAt})';
}


}

/// @nodoc
abstract mixin class $PhotoCopyWith<$Res>  {
  factory $PhotoCopyWith(Photo value, $Res Function(Photo) _then) = _$PhotoCopyWithImpl;
@useResult
$Res call({
 String id, String observationId, String localPath, String? remoteUrl, int width, int height, int fileSize, String mimeType, DateTime capturedAt, double? latitude, double? longitude, double? altitude, double? gpsAccuracy, String? deviceId, Map<String, dynamic>? exifData, PhotoStatus status, DateTime? uploadedAt
});




}
/// @nodoc
class _$PhotoCopyWithImpl<$Res>
    implements $PhotoCopyWith<$Res> {
  _$PhotoCopyWithImpl(this._self, this._then);

  final Photo _self;
  final $Res Function(Photo) _then;

/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? observationId = null,Object? localPath = null,Object? remoteUrl = freezed,Object? width = null,Object? height = null,Object? fileSize = null,Object? mimeType = null,Object? capturedAt = null,Object? latitude = freezed,Object? longitude = freezed,Object? altitude = freezed,Object? gpsAccuracy = freezed,Object? deviceId = freezed,Object? exifData = freezed,Object? status = null,Object? uploadedAt = freezed,}) {
  return _then(Photo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,observationId: null == observationId ? _self.observationId : observationId // ignore: cast_nullable_to_non_nullable
as String,localPath: null == localPath ? _self.localPath : localPath // ignore: cast_nullable_to_non_nullable
as String,remoteUrl: freezed == remoteUrl ? _self.remoteUrl : remoteUrl // ignore: cast_nullable_to_non_nullable
as String?,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,capturedAt: null == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,altitude: freezed == altitude ? _self.altitude : altitude // ignore: cast_nullable_to_non_nullable
as double?,gpsAccuracy: freezed == gpsAccuracy ? _self.gpsAccuracy : gpsAccuracy // ignore: cast_nullable_to_non_nullable
as double?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,exifData: freezed == exifData ? _self.exifData : exifData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PhotoStatus,uploadedAt: freezed == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Photo].
extension PhotoPatterns on Photo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Photo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Photo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Photo value)  $default,){
final _that = this;
switch (_that) {
case _Photo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Photo value)?  $default,){
final _that = this;
switch (_that) {
case _Photo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String observationId,  String localPath,  String? remoteUrl,  int width,  int height,  int fileSize,  String mimeType,  DateTime capturedAt,  double? latitude,  double? longitude,  double? altitude,  double? gpsAccuracy,  String? deviceId,  Map<String, dynamic>? exifData,  PhotoStatus status,  DateTime? uploadedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Photo() when $default != null:
return $default(_that.id,_that.observationId,_that.localPath,_that.remoteUrl,_that.width,_that.height,_that.fileSize,_that.mimeType,_that.capturedAt,_that.latitude,_that.longitude,_that.altitude,_that.gpsAccuracy,_that.deviceId,_that.exifData,_that.status,_that.uploadedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String observationId,  String localPath,  String? remoteUrl,  int width,  int height,  int fileSize,  String mimeType,  DateTime capturedAt,  double? latitude,  double? longitude,  double? altitude,  double? gpsAccuracy,  String? deviceId,  Map<String, dynamic>? exifData,  PhotoStatus status,  DateTime? uploadedAt)  $default,) {final _that = this;
switch (_that) {
case _Photo():
return $default(_that.id,_that.observationId,_that.localPath,_that.remoteUrl,_that.width,_that.height,_that.fileSize,_that.mimeType,_that.capturedAt,_that.latitude,_that.longitude,_that.altitude,_that.gpsAccuracy,_that.deviceId,_that.exifData,_that.status,_that.uploadedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String observationId,  String localPath,  String? remoteUrl,  int width,  int height,  int fileSize,  String mimeType,  DateTime capturedAt,  double? latitude,  double? longitude,  double? altitude,  double? gpsAccuracy,  String? deviceId,  Map<String, dynamic>? exifData,  PhotoStatus status,  DateTime? uploadedAt)?  $default,) {final _that = this;
switch (_that) {
case _Photo() when $default != null:
return $default(_that.id,_that.observationId,_that.localPath,_that.remoteUrl,_that.width,_that.height,_that.fileSize,_that.mimeType,_that.capturedAt,_that.latitude,_that.longitude,_that.altitude,_that.gpsAccuracy,_that.deviceId,_that.exifData,_that.status,_that.uploadedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Photo implements Photo {
  const _Photo({required this.id, required this.observationId, required this.localPath, this.remoteUrl, required this.width, required this.height, required this.fileSize, required this.mimeType, required this.capturedAt, this.latitude, this.longitude, this.altitude, this.gpsAccuracy, this.deviceId,  Map<String, dynamic>? exifData, this.status = PhotoStatus.local, this.uploadedAt}): _exifData = exifData;
  factory _Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

@override final  String id;
@override final  String observationId;
@override final  String localPath;
@override final  String? remoteUrl;
@override final  int width;
@override final  int height;
@override final  int fileSize;
@override final  String mimeType;
@override final  DateTime capturedAt;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? altitude;
@override final  double? gpsAccuracy;
@override final  String? deviceId;
 final  Map<String, dynamic>? _exifData;
@override Map<String, dynamic>? get exifData {
  final value = _exifData;
  if (value == null) return null;
  if (_exifData is EqualUnmodifiableMapView) return _exifData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey() final  PhotoStatus status;
@override final  DateTime? uploadedAt;

/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhotoCopyWith<_Photo> get copyWith => __$PhotoCopyWithImpl<_Photo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhotoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Photo&&(identical(other.id, id) || other.id == id)&&(identical(other.observationId, observationId) || other.observationId == observationId)&&(identical(other.localPath, localPath) || other.localPath == localPath)&&(identical(other.remoteUrl, remoteUrl) || other.remoteUrl == remoteUrl)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.gpsAccuracy, gpsAccuracy) || other.gpsAccuracy == gpsAccuracy)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&const DeepCollectionEquality().equals(other.exifData, _exifData)&&(identical(other.status, status) || other.status == status)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,observationId,localPath,remoteUrl,width,height,fileSize,mimeType,capturedAt,latitude,longitude,altitude,gpsAccuracy,deviceId,const DeepCollectionEquality().hash(_exifData),status,uploadedAt);
}

@override
String toString() {
    return 'Photo(id: $id, observationId: $observationId, localPath: $localPath, remoteUrl: $remoteUrl, width: $width, height: $height, fileSize: $fileSize, mimeType: $mimeType, capturedAt: $capturedAt, latitude: $latitude, longitude: $longitude, altitude: $altitude, gpsAccuracy: $gpsAccuracy, deviceId: $deviceId, exifData: $exifData, status: $status, uploadedAt: $uploadedAt)';
}


}

/// @nodoc
abstract mixin class _$PhotoCopyWith<$Res> implements $PhotoCopyWith<$Res> {
  factory _$PhotoCopyWith(_Photo value, $Res Function(_Photo) _then) = __$PhotoCopyWithImpl;
@override @useResult
$Res call({
 String id, String observationId, String localPath, String? remoteUrl, int width, int height, int fileSize, String mimeType, DateTime capturedAt, double? latitude, double? longitude, double? altitude, double? gpsAccuracy, String? deviceId, Map<String, dynamic>? exifData, PhotoStatus status, DateTime? uploadedAt
});




}
/// @nodoc
class __$PhotoCopyWithImpl<$Res>
    implements _$PhotoCopyWith<$Res> {
  __$PhotoCopyWithImpl(this._self, this._then);

  final _Photo _self;
  final $Res Function(_Photo) _then;

/// Create a copy of Photo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? observationId = null,Object? localPath = null,Object? remoteUrl = freezed,Object? width = null,Object? height = null,Object? fileSize = null,Object? mimeType = null,Object? capturedAt = null,Object? latitude = freezed,Object? longitude = freezed,Object? altitude = freezed,Object? gpsAccuracy = freezed,Object? deviceId = freezed,Object? exifData = freezed,Object? status = null,Object? uploadedAt = freezed,}) {
  return _then(_Photo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,observationId: null == observationId ? _self.observationId : observationId // ignore: cast_nullable_to_non_nullable
as String,localPath: null == localPath ? _self.localPath : localPath // ignore: cast_nullable_to_non_nullable
as String,remoteUrl: freezed == remoteUrl ? _self.remoteUrl : remoteUrl // ignore: cast_nullable_to_non_nullable
as String?,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,capturedAt: null == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,altitude: freezed == altitude ? _self.altitude : altitude // ignore: cast_nullable_to_non_nullable
as double?,gpsAccuracy: freezed == gpsAccuracy ? _self.gpsAccuracy : gpsAccuracy // ignore: cast_nullable_to_non_nullable
as double?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,exifData: freezed == exifData ? _self._exifData : exifData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PhotoStatus,uploadedAt: freezed == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
