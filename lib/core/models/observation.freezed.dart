// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Observation {

 String get id; String get watershedId; String get userId; ObservationType get type; ObservationStatus get status; LatLng get location; double get gpsAccuracy; DateTime get timestamp; String? get notes; List<String>? get photoIds; String? get interventionId; Map<String, dynamic>? get metadata; DateTime? get createdAt; DateTime? get updatedAt; DateTime? get syncedAt;
/// Create a copy of Observation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservationCopyWith<Observation> get copyWith => _$ObservationCopyWithImpl<Observation>(this as Observation, _$identity);

  /// Serializes this Observation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Observation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Observation&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.watershedId, _this.watershedId) || other.watershedId == _this.watershedId)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.gpsAccuracy, _this.gpsAccuracy) || other.gpsAccuracy == _this.gpsAccuracy)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&const DeepCollectionEquality().equals(other.photoIds, _this.photoIds)&&(identical(other.interventionId, _this.interventionId) || other.interventionId == _this.interventionId)&&const DeepCollectionEquality().equals(other.metadata, _this.metadata)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.syncedAt, _this.syncedAt) || other.syncedAt == _this.syncedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Observation;
  return Object.hash(runtimeType,_this.id,_this.watershedId,_this.userId,_this.type,_this.status,_this.location,_this.gpsAccuracy,_this.timestamp,_this.notes,const DeepCollectionEquality().hash(_this.photoIds),_this.interventionId,const DeepCollectionEquality().hash(_this.metadata),_this.createdAt,_this.updatedAt,_this.syncedAt);
}

@override
String toString() {
  final _this = this as Observation;
  return 'Observation(id: ${_this.id}, watershedId: ${_this.watershedId}, userId: ${_this.userId}, type: ${_this.type}, status: ${_this.status}, location: ${_this.location}, gpsAccuracy: ${_this.gpsAccuracy}, timestamp: ${_this.timestamp}, notes: ${_this.notes}, photoIds: ${_this.photoIds}, interventionId: ${_this.interventionId}, metadata: ${_this.metadata}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, syncedAt: ${_this.syncedAt})';
}


}

/// @nodoc
abstract mixin class $ObservationCopyWith<$Res>  {
  factory $ObservationCopyWith(Observation value, $Res Function(Observation) _then) = _$ObservationCopyWithImpl;
@useResult
$Res call({
 String id, String watershedId, String userId, ObservationType type, ObservationStatus status, LatLng location, double gpsAccuracy, DateTime timestamp, String? notes, List<String>? photoIds, String? interventionId, Map<String, dynamic>? metadata, DateTime? createdAt, DateTime? updatedAt, DateTime? syncedAt
});




}
/// @nodoc
class _$ObservationCopyWithImpl<$Res>
    implements $ObservationCopyWith<$Res> {
  _$ObservationCopyWithImpl(this._self, this._then);

  final Observation _self;
  final $Res Function(Observation) _then;

/// Create a copy of Observation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? watershedId = null,Object? userId = null,Object? type = null,Object? status = null,Object? location = null,Object? gpsAccuracy = null,Object? timestamp = null,Object? notes = freezed,Object? photoIds = freezed,Object? interventionId = freezed,Object? metadata = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? syncedAt = freezed,}) {
  return _then(Observation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,watershedId: null == watershedId ? _self.watershedId : watershedId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ObservationType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ObservationStatus,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,gpsAccuracy: null == gpsAccuracy ? _self.gpsAccuracy : gpsAccuracy // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoIds: freezed == photoIds ? _self.photoIds : photoIds // ignore: cast_nullable_to_non_nullable
as List<String>?,interventionId: freezed == interventionId ? _self.interventionId : interventionId // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,syncedAt: freezed == syncedAt ? _self.syncedAt : syncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Observation].
extension ObservationPatterns on Observation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Observation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Observation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Observation value)  $default,){
final _that = this;
switch (_that) {
case _Observation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Observation value)?  $default,){
final _that = this;
switch (_that) {
case _Observation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String watershedId,  String userId,  ObservationType type,  ObservationStatus status,  LatLng location,  double gpsAccuracy,  DateTime timestamp,  String? notes,  List<String>? photoIds,  String? interventionId,  Map<String, dynamic>? metadata,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? syncedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Observation() when $default != null:
return $default(_that.id,_that.watershedId,_that.userId,_that.type,_that.status,_that.location,_that.gpsAccuracy,_that.timestamp,_that.notes,_that.photoIds,_that.interventionId,_that.metadata,_that.createdAt,_that.updatedAt,_that.syncedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String watershedId,  String userId,  ObservationType type,  ObservationStatus status,  LatLng location,  double gpsAccuracy,  DateTime timestamp,  String? notes,  List<String>? photoIds,  String? interventionId,  Map<String, dynamic>? metadata,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? syncedAt)  $default,) {final _that = this;
switch (_that) {
case _Observation():
return $default(_that.id,_that.watershedId,_that.userId,_that.type,_that.status,_that.location,_that.gpsAccuracy,_that.timestamp,_that.notes,_that.photoIds,_that.interventionId,_that.metadata,_that.createdAt,_that.updatedAt,_that.syncedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String watershedId,  String userId,  ObservationType type,  ObservationStatus status,  LatLng location,  double gpsAccuracy,  DateTime timestamp,  String? notes,  List<String>? photoIds,  String? interventionId,  Map<String, dynamic>? metadata,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? syncedAt)?  $default,) {final _that = this;
switch (_that) {
case _Observation() when $default != null:
return $default(_that.id,_that.watershedId,_that.userId,_that.type,_that.status,_that.location,_that.gpsAccuracy,_that.timestamp,_that.notes,_that.photoIds,_that.interventionId,_that.metadata,_that.createdAt,_that.updatedAt,_that.syncedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Observation implements Observation {
  const _Observation({required this.id, required this.watershedId, required this.userId, required this.type, required this.status, required this.location, required this.gpsAccuracy, required this.timestamp, this.notes,  List<String>? photoIds, this.interventionId,  Map<String, dynamic>? metadata, this.createdAt, this.updatedAt, this.syncedAt}): _photoIds = photoIds,_metadata = metadata;
  factory _Observation.fromJson(Map<String, dynamic> json) => _$ObservationFromJson(json);

@override final  String id;
@override final  String watershedId;
@override final  String userId;
@override final  ObservationType type;
@override final  ObservationStatus status;
@override final  LatLng location;
@override final  double gpsAccuracy;
@override final  DateTime timestamp;
@override final  String? notes;
 final  List<String>? _photoIds;
@override List<String>? get photoIds {
  final value = _photoIds;
  if (value == null) return null;
  if (_photoIds is EqualUnmodifiableListView) return _photoIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? interventionId;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  DateTime? syncedAt;

/// Create a copy of Observation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObservationCopyWith<_Observation> get copyWith => __$ObservationCopyWithImpl<_Observation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ObservationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Observation&&(identical(other.id, id) || other.id == id)&&(identical(other.watershedId, watershedId) || other.watershedId == watershedId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.location, location) || other.location == location)&&(identical(other.gpsAccuracy, gpsAccuracy) || other.gpsAccuracy == gpsAccuracy)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.photoIds, _photoIds)&&(identical(other.interventionId, interventionId) || other.interventionId == interventionId)&&const DeepCollectionEquality().equals(other.metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncedAt, syncedAt) || other.syncedAt == syncedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,watershedId,userId,type,status,location,gpsAccuracy,timestamp,notes,const DeepCollectionEquality().hash(_photoIds),interventionId,const DeepCollectionEquality().hash(_metadata),createdAt,updatedAt,syncedAt);
}

@override
String toString() {
    return 'Observation(id: $id, watershedId: $watershedId, userId: $userId, type: $type, status: $status, location: $location, gpsAccuracy: $gpsAccuracy, timestamp: $timestamp, notes: $notes, photoIds: $photoIds, interventionId: $interventionId, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt)';
}


}

/// @nodoc
abstract mixin class _$ObservationCopyWith<$Res> implements $ObservationCopyWith<$Res> {
  factory _$ObservationCopyWith(_Observation value, $Res Function(_Observation) _then) = __$ObservationCopyWithImpl;
@override @useResult
$Res call({
 String id, String watershedId, String userId, ObservationType type, ObservationStatus status, LatLng location, double gpsAccuracy, DateTime timestamp, String? notes, List<String>? photoIds, String? interventionId, Map<String, dynamic>? metadata, DateTime? createdAt, DateTime? updatedAt, DateTime? syncedAt
});




}
/// @nodoc
class __$ObservationCopyWithImpl<$Res>
    implements _$ObservationCopyWith<$Res> {
  __$ObservationCopyWithImpl(this._self, this._then);

  final _Observation _self;
  final $Res Function(_Observation) _then;

/// Create a copy of Observation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? watershedId = null,Object? userId = null,Object? type = null,Object? status = null,Object? location = null,Object? gpsAccuracy = null,Object? timestamp = null,Object? notes = freezed,Object? photoIds = freezed,Object? interventionId = freezed,Object? metadata = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? syncedAt = freezed,}) {
  return _then(_Observation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,watershedId: null == watershedId ? _self.watershedId : watershedId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ObservationType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ObservationStatus,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LatLng,gpsAccuracy: null == gpsAccuracy ? _self.gpsAccuracy : gpsAccuracy // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,photoIds: freezed == photoIds ? _self._photoIds : photoIds // ignore: cast_nullable_to_non_nullable
as List<String>?,interventionId: freezed == interventionId ? _self.interventionId : interventionId // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,syncedAt: freezed == syncedAt ? _self.syncedAt : syncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
