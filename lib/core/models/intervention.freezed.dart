// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intervention.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Intervention {

 String get id; String get watershedId; String get name; InterventionType get type; InterventionStatus get status; String get description; DateTime get plannedDate; DateTime? get actualDate; double get estimatedCost; double? get actualCost; String? get contractor; List<String>? get photoIds; Map<String, dynamic>? get metadata; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Intervention
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterventionCopyWith<Intervention> get copyWith => _$InterventionCopyWithImpl<Intervention>(this as Intervention, _$identity);

  /// Serializes this Intervention to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Intervention;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Intervention&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.watershedId, _this.watershedId) || other.watershedId == _this.watershedId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.plannedDate, _this.plannedDate) || other.plannedDate == _this.plannedDate)&&(identical(other.actualDate, _this.actualDate) || other.actualDate == _this.actualDate)&&(identical(other.estimatedCost, _this.estimatedCost) || other.estimatedCost == _this.estimatedCost)&&(identical(other.actualCost, _this.actualCost) || other.actualCost == _this.actualCost)&&(identical(other.contractor, _this.contractor) || other.contractor == _this.contractor)&&const DeepCollectionEquality().equals(other.photoIds, _this.photoIds)&&const DeepCollectionEquality().equals(other.metadata, _this.metadata)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Intervention;
  return Object.hash(runtimeType,_this.id,_this.watershedId,_this.name,_this.type,_this.status,_this.description,_this.plannedDate,_this.actualDate,_this.estimatedCost,_this.actualCost,_this.contractor,const DeepCollectionEquality().hash(_this.photoIds),const DeepCollectionEquality().hash(_this.metadata),_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Intervention;
  return 'Intervention(id: ${_this.id}, watershedId: ${_this.watershedId}, name: ${_this.name}, type: ${_this.type}, status: ${_this.status}, description: ${_this.description}, plannedDate: ${_this.plannedDate}, actualDate: ${_this.actualDate}, estimatedCost: ${_this.estimatedCost}, actualCost: ${_this.actualCost}, contractor: ${_this.contractor}, photoIds: ${_this.photoIds}, metadata: ${_this.metadata}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $InterventionCopyWith<$Res>  {
  factory $InterventionCopyWith(Intervention value, $Res Function(Intervention) _then) = _$InterventionCopyWithImpl;
@useResult
$Res call({
 String id, String watershedId, String name, InterventionType type, InterventionStatus status, String description, DateTime plannedDate, DateTime? actualDate, double estimatedCost, double? actualCost, String? contractor, List<String>? photoIds, Map<String, dynamic>? metadata, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$InterventionCopyWithImpl<$Res>
    implements $InterventionCopyWith<$Res> {
  _$InterventionCopyWithImpl(this._self, this._then);

  final Intervention _self;
  final $Res Function(Intervention) _then;

/// Create a copy of Intervention
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? watershedId = null,Object? name = null,Object? type = null,Object? status = null,Object? description = null,Object? plannedDate = null,Object? actualDate = freezed,Object? estimatedCost = null,Object? actualCost = freezed,Object? contractor = freezed,Object? photoIds = freezed,Object? metadata = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(Intervention(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,watershedId: null == watershedId ? _self.watershedId : watershedId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InterventionType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InterventionStatus,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,plannedDate: null == plannedDate ? _self.plannedDate : plannedDate // ignore: cast_nullable_to_non_nullable
as DateTime,actualDate: freezed == actualDate ? _self.actualDate : actualDate // ignore: cast_nullable_to_non_nullable
as DateTime?,estimatedCost: null == estimatedCost ? _self.estimatedCost : estimatedCost // ignore: cast_nullable_to_non_nullable
as double,actualCost: freezed == actualCost ? _self.actualCost : actualCost // ignore: cast_nullable_to_non_nullable
as double?,contractor: freezed == contractor ? _self.contractor : contractor // ignore: cast_nullable_to_non_nullable
as String?,photoIds: freezed == photoIds ? _self.photoIds : photoIds // ignore: cast_nullable_to_non_nullable
as List<String>?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Intervention].
extension InterventionPatterns on Intervention {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Intervention value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Intervention() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Intervention value)  $default,){
final _that = this;
switch (_that) {
case _Intervention():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Intervention value)?  $default,){
final _that = this;
switch (_that) {
case _Intervention() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String watershedId,  String name,  InterventionType type,  InterventionStatus status,  String description,  DateTime plannedDate,  DateTime? actualDate,  double estimatedCost,  double? actualCost,  String? contractor,  List<String>? photoIds,  Map<String, dynamic>? metadata,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Intervention() when $default != null:
return $default(_that.id,_that.watershedId,_that.name,_that.type,_that.status,_that.description,_that.plannedDate,_that.actualDate,_that.estimatedCost,_that.actualCost,_that.contractor,_that.photoIds,_that.metadata,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String watershedId,  String name,  InterventionType type,  InterventionStatus status,  String description,  DateTime plannedDate,  DateTime? actualDate,  double estimatedCost,  double? actualCost,  String? contractor,  List<String>? photoIds,  Map<String, dynamic>? metadata,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Intervention():
return $default(_that.id,_that.watershedId,_that.name,_that.type,_that.status,_that.description,_that.plannedDate,_that.actualDate,_that.estimatedCost,_that.actualCost,_that.contractor,_that.photoIds,_that.metadata,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String watershedId,  String name,  InterventionType type,  InterventionStatus status,  String description,  DateTime plannedDate,  DateTime? actualDate,  double estimatedCost,  double? actualCost,  String? contractor,  List<String>? photoIds,  Map<String, dynamic>? metadata,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Intervention() when $default != null:
return $default(_that.id,_that.watershedId,_that.name,_that.type,_that.status,_that.description,_that.plannedDate,_that.actualDate,_that.estimatedCost,_that.actualCost,_that.contractor,_that.photoIds,_that.metadata,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Intervention implements Intervention {
  const _Intervention({required this.id, required this.watershedId, required this.name, required this.type, required this.status, required this.description, required this.plannedDate, this.actualDate, required this.estimatedCost, this.actualCost, this.contractor,  List<String>? photoIds,  Map<String, dynamic>? metadata, this.createdAt, this.updatedAt}): _photoIds = photoIds,_metadata = metadata;
  factory _Intervention.fromJson(Map<String, dynamic> json) => _$InterventionFromJson(json);

@override final  String id;
@override final  String watershedId;
@override final  String name;
@override final  InterventionType type;
@override final  InterventionStatus status;
@override final  String description;
@override final  DateTime plannedDate;
@override final  DateTime? actualDate;
@override final  double estimatedCost;
@override final  double? actualCost;
@override final  String? contractor;
 final  List<String>? _photoIds;
@override List<String>? get photoIds {
  final value = _photoIds;
  if (value == null) return null;
  if (_photoIds is EqualUnmodifiableListView) return _photoIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

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

/// Create a copy of Intervention
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterventionCopyWith<_Intervention> get copyWith => __$InterventionCopyWithImpl<_Intervention>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterventionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Intervention&&(identical(other.id, id) || other.id == id)&&(identical(other.watershedId, watershedId) || other.watershedId == watershedId)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&(identical(other.plannedDate, plannedDate) || other.plannedDate == plannedDate)&&(identical(other.actualDate, actualDate) || other.actualDate == actualDate)&&(identical(other.estimatedCost, estimatedCost) || other.estimatedCost == estimatedCost)&&(identical(other.actualCost, actualCost) || other.actualCost == actualCost)&&(identical(other.contractor, contractor) || other.contractor == contractor)&&const DeepCollectionEquality().equals(other.photoIds, _photoIds)&&const DeepCollectionEquality().equals(other.metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,watershedId,name,type,status,description,plannedDate,actualDate,estimatedCost,actualCost,contractor,const DeepCollectionEquality().hash(_photoIds),const DeepCollectionEquality().hash(_metadata),createdAt,updatedAt);
}

@override
String toString() {
    return 'Intervention(id: $id, watershedId: $watershedId, name: $name, type: $type, status: $status, description: $description, plannedDate: $plannedDate, actualDate: $actualDate, estimatedCost: $estimatedCost, actualCost: $actualCost, contractor: $contractor, photoIds: $photoIds, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$InterventionCopyWith<$Res> implements $InterventionCopyWith<$Res> {
  factory _$InterventionCopyWith(_Intervention value, $Res Function(_Intervention) _then) = __$InterventionCopyWithImpl;
@override @useResult
$Res call({
 String id, String watershedId, String name, InterventionType type, InterventionStatus status, String description, DateTime plannedDate, DateTime? actualDate, double estimatedCost, double? actualCost, String? contractor, List<String>? photoIds, Map<String, dynamic>? metadata, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$InterventionCopyWithImpl<$Res>
    implements _$InterventionCopyWith<$Res> {
  __$InterventionCopyWithImpl(this._self, this._then);

  final _Intervention _self;
  final $Res Function(_Intervention) _then;

/// Create a copy of Intervention
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? watershedId = null,Object? name = null,Object? type = null,Object? status = null,Object? description = null,Object? plannedDate = null,Object? actualDate = freezed,Object? estimatedCost = null,Object? actualCost = freezed,Object? contractor = freezed,Object? photoIds = freezed,Object? metadata = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Intervention(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,watershedId: null == watershedId ? _self.watershedId : watershedId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InterventionType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InterventionStatus,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,plannedDate: null == plannedDate ? _self.plannedDate : plannedDate // ignore: cast_nullable_to_non_nullable
as DateTime,actualDate: freezed == actualDate ? _self.actualDate : actualDate // ignore: cast_nullable_to_non_nullable
as DateTime?,estimatedCost: null == estimatedCost ? _self.estimatedCost : estimatedCost // ignore: cast_nullable_to_non_nullable
as double,actualCost: freezed == actualCost ? _self.actualCost : actualCost // ignore: cast_nullable_to_non_nullable
as double?,contractor: freezed == contractor ? _self.contractor : contractor // ignore: cast_nullable_to_non_nullable
as String?,photoIds: freezed == photoIds ? _self._photoIds : photoIds // ignore: cast_nullable_to_non_nullable
as List<String>?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
