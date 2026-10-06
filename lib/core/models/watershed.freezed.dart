// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watershed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Watershed {

 String get id; String get name; String get code; String get description; LatLng get center; double get areaKm2; String get state; String get district; List<String>? get programIds; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Watershed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatershedCopyWith<Watershed> get copyWith => _$WatershedCopyWithImpl<Watershed>(this as Watershed, _$identity);

  /// Serializes this Watershed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Watershed;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Watershed&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.center, _this.center) || other.center == _this.center)&&(identical(other.areaKm2, _this.areaKm2) || other.areaKm2 == _this.areaKm2)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.district, _this.district) || other.district == _this.district)&&const DeepCollectionEquality().equals(other.programIds, _this.programIds)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Watershed;
  return Object.hash(runtimeType,_this.id,_this.name,_this.code,_this.description,_this.center,_this.areaKm2,_this.state,_this.district,const DeepCollectionEquality().hash(_this.programIds),_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Watershed;
  return 'Watershed(id: ${_this.id}, name: ${_this.name}, code: ${_this.code}, description: ${_this.description}, center: ${_this.center}, areaKm2: ${_this.areaKm2}, state: ${_this.state}, district: ${_this.district}, programIds: ${_this.programIds}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $WatershedCopyWith<$Res>  {
  factory $WatershedCopyWith(Watershed value, $Res Function(Watershed) _then) = _$WatershedCopyWithImpl;
@useResult
$Res call({
 String id, String name, String code, String description, LatLng center, double areaKm2, String state, String district, List<String>? programIds, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$WatershedCopyWithImpl<$Res>
    implements $WatershedCopyWith<$Res> {
  _$WatershedCopyWithImpl(this._self, this._then);

  final Watershed _self;
  final $Res Function(Watershed) _then;

/// Create a copy of Watershed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = null,Object? description = null,Object? center = null,Object? areaKm2 = null,Object? state = null,Object? district = null,Object? programIds = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(Watershed(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as LatLng,areaKm2: null == areaKm2 ? _self.areaKm2 : areaKm2 // ignore: cast_nullable_to_non_nullable
as double,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,programIds: freezed == programIds ? _self.programIds : programIds // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Watershed].
extension WatershedPatterns on Watershed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Watershed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Watershed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Watershed value)  $default,){
final _that = this;
switch (_that) {
case _Watershed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Watershed value)?  $default,){
final _that = this;
switch (_that) {
case _Watershed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String code,  String description,  LatLng center,  double areaKm2,  String state,  String district,  List<String>? programIds,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Watershed() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.description,_that.center,_that.areaKm2,_that.state,_that.district,_that.programIds,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String code,  String description,  LatLng center,  double areaKm2,  String state,  String district,  List<String>? programIds,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Watershed():
return $default(_that.id,_that.name,_that.code,_that.description,_that.center,_that.areaKm2,_that.state,_that.district,_that.programIds,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String code,  String description,  LatLng center,  double areaKm2,  String state,  String district,  List<String>? programIds,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Watershed() when $default != null:
return $default(_that.id,_that.name,_that.code,_that.description,_that.center,_that.areaKm2,_that.state,_that.district,_that.programIds,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Watershed implements Watershed {
  const _Watershed({required this.id, required this.name, required this.code, required this.description, required this.center, required this.areaKm2, required this.state, required this.district,  List<String>? programIds, this.createdAt, this.updatedAt}): _programIds = programIds;
  factory _Watershed.fromJson(Map<String, dynamic> json) => _$WatershedFromJson(json);

@override final  String id;
@override final  String name;
@override final  String code;
@override final  String description;
@override final  LatLng center;
@override final  double areaKm2;
@override final  String state;
@override final  String district;
 final  List<String>? _programIds;
@override List<String>? get programIds {
  final value = _programIds;
  if (value == null) return null;
  if (_programIds is EqualUnmodifiableListView) return _programIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Watershed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatershedCopyWith<_Watershed> get copyWith => __$WatershedCopyWithImpl<_Watershed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WatershedToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Watershed&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.center, center) || other.center == center)&&(identical(other.areaKm2, areaKm2) || other.areaKm2 == areaKm2)&&(identical(other.state, state) || other.state == state)&&(identical(other.district, district) || other.district == district)&&const DeepCollectionEquality().equals(other.programIds, _programIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,code,description,center,areaKm2,state,district,const DeepCollectionEquality().hash(_programIds),createdAt,updatedAt);
}

@override
String toString() {
    return 'Watershed(id: $id, name: $name, code: $code, description: $description, center: $center, areaKm2: $areaKm2, state: $state, district: $district, programIds: $programIds, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WatershedCopyWith<$Res> implements $WatershedCopyWith<$Res> {
  factory _$WatershedCopyWith(_Watershed value, $Res Function(_Watershed) _then) = __$WatershedCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String code, String description, LatLng center, double areaKm2, String state, String district, List<String>? programIds, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$WatershedCopyWithImpl<$Res>
    implements _$WatershedCopyWith<$Res> {
  __$WatershedCopyWithImpl(this._self, this._then);

  final _Watershed _self;
  final $Res Function(_Watershed) _then;

/// Create a copy of Watershed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = null,Object? description = null,Object? center = null,Object? areaKm2 = null,Object? state = null,Object? district = null,Object? programIds = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Watershed(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as LatLng,areaKm2: null == areaKm2 ? _self.areaKm2 : areaKm2 // ignore: cast_nullable_to_non_nullable
as double,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,programIds: freezed == programIds ? _self._programIds : programIds // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$WatershedBoundary {

 String get watershedId; List<LatLng> get coordinates; String get geometryType;
/// Create a copy of WatershedBoundary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatershedBoundaryCopyWith<WatershedBoundary> get copyWith => _$WatershedBoundaryCopyWithImpl<WatershedBoundary>(this as WatershedBoundary, _$identity);

  /// Serializes this WatershedBoundary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WatershedBoundary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatershedBoundary&&(identical(other.watershedId, _this.watershedId) || other.watershedId == _this.watershedId)&&const DeepCollectionEquality().equals(other.coordinates, _this.coordinates)&&(identical(other.geometryType, _this.geometryType) || other.geometryType == _this.geometryType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WatershedBoundary;
  return Object.hash(runtimeType,_this.watershedId,const DeepCollectionEquality().hash(_this.coordinates),_this.geometryType);
}

@override
String toString() {
  final _this = this as WatershedBoundary;
  return 'WatershedBoundary(watershedId: ${_this.watershedId}, coordinates: ${_this.coordinates}, geometryType: ${_this.geometryType})';
}


}

/// @nodoc
abstract mixin class $WatershedBoundaryCopyWith<$Res>  {
  factory $WatershedBoundaryCopyWith(WatershedBoundary value, $Res Function(WatershedBoundary) _then) = _$WatershedBoundaryCopyWithImpl;
@useResult
$Res call({
 String watershedId, List<LatLng> coordinates, String geometryType
});




}
/// @nodoc
class _$WatershedBoundaryCopyWithImpl<$Res>
    implements $WatershedBoundaryCopyWith<$Res> {
  _$WatershedBoundaryCopyWithImpl(this._self, this._then);

  final WatershedBoundary _self;
  final $Res Function(WatershedBoundary) _then;

/// Create a copy of WatershedBoundary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? watershedId = null,Object? coordinates = null,Object? geometryType = null,}) {
  return _then(WatershedBoundary(
watershedId: null == watershedId ? _self.watershedId : watershedId // ignore: cast_nullable_to_non_nullable
as String,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<LatLng>,geometryType: null == geometryType ? _self.geometryType : geometryType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WatershedBoundary].
extension WatershedBoundaryPatterns on WatershedBoundary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatershedBoundary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatershedBoundary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatershedBoundary value)  $default,){
final _that = this;
switch (_that) {
case _WatershedBoundary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatershedBoundary value)?  $default,){
final _that = this;
switch (_that) {
case _WatershedBoundary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String watershedId,  List<LatLng> coordinates,  String geometryType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatershedBoundary() when $default != null:
return $default(_that.watershedId,_that.coordinates,_that.geometryType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String watershedId,  List<LatLng> coordinates,  String geometryType)  $default,) {final _that = this;
switch (_that) {
case _WatershedBoundary():
return $default(_that.watershedId,_that.coordinates,_that.geometryType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String watershedId,  List<LatLng> coordinates,  String geometryType)?  $default,) {final _that = this;
switch (_that) {
case _WatershedBoundary() when $default != null:
return $default(_that.watershedId,_that.coordinates,_that.geometryType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WatershedBoundary implements WatershedBoundary {
  const _WatershedBoundary({required this.watershedId, required  List<LatLng> coordinates, required this.geometryType}): _coordinates = coordinates;
  factory _WatershedBoundary.fromJson(Map<String, dynamic> json) => _$WatershedBoundaryFromJson(json);

@override final  String watershedId;
 final  List<LatLng> _coordinates;
@override List<LatLng> get coordinates {
  if (_coordinates is EqualUnmodifiableListView) return _coordinates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coordinates);
}

@override final  String geometryType;

/// Create a copy of WatershedBoundary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatershedBoundaryCopyWith<_WatershedBoundary> get copyWith => __$WatershedBoundaryCopyWithImpl<_WatershedBoundary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WatershedBoundaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatershedBoundary&&(identical(other.watershedId, watershedId) || other.watershedId == watershedId)&&const DeepCollectionEquality().equals(other.coordinates, _coordinates)&&(identical(other.geometryType, geometryType) || other.geometryType == geometryType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,watershedId,const DeepCollectionEquality().hash(_coordinates),geometryType);
}

@override
String toString() {
    return 'WatershedBoundary(watershedId: $watershedId, coordinates: $coordinates, geometryType: $geometryType)';
}


}

/// @nodoc
abstract mixin class _$WatershedBoundaryCopyWith<$Res> implements $WatershedBoundaryCopyWith<$Res> {
  factory _$WatershedBoundaryCopyWith(_WatershedBoundary value, $Res Function(_WatershedBoundary) _then) = __$WatershedBoundaryCopyWithImpl;
@override @useResult
$Res call({
 String watershedId, List<LatLng> coordinates, String geometryType
});




}
/// @nodoc
class __$WatershedBoundaryCopyWithImpl<$Res>
    implements _$WatershedBoundaryCopyWith<$Res> {
  __$WatershedBoundaryCopyWithImpl(this._self, this._then);

  final _WatershedBoundary _self;
  final $Res Function(_WatershedBoundary) _then;

/// Create a copy of WatershedBoundary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? watershedId = null,Object? coordinates = null,Object? geometryType = null,}) {
  return _then(_WatershedBoundary(
watershedId: null == watershedId ? _self.watershedId : watershedId // ignore: cast_nullable_to_non_nullable
as String,coordinates: null == coordinates ? _self._coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as List<LatLng>,geometryType: null == geometryType ? _self.geometryType : geometryType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
