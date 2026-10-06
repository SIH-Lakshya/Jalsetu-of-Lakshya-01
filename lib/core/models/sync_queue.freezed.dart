// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_queue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncQueueItem {

 String get id; SyncEntityType get entityType; String get entityId; SyncOperation get operation; Map<String, dynamic> get payload; int get retryCount; DateTime get createdAt; DateTime? get lastAttemptAt; String? get errorMessage; SyncStatus get status;
/// Create a copy of SyncQueueItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncQueueItemCopyWith<SyncQueueItem> get copyWith => _$SyncQueueItemCopyWithImpl<SyncQueueItem>(this as SyncQueueItem, _$identity);

  /// Serializes this SyncQueueItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SyncQueueItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncQueueItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.entityType, _this.entityType) || other.entityType == _this.entityType)&&(identical(other.entityId, _this.entityId) || other.entityId == _this.entityId)&&(identical(other.operation, _this.operation) || other.operation == _this.operation)&&const DeepCollectionEquality().equals(other.payload, _this.payload)&&(identical(other.retryCount, _this.retryCount) || other.retryCount == _this.retryCount)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.lastAttemptAt, _this.lastAttemptAt) || other.lastAttemptAt == _this.lastAttemptAt)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SyncQueueItem;
  return Object.hash(runtimeType,_this.id,_this.entityType,_this.entityId,_this.operation,const DeepCollectionEquality().hash(_this.payload),_this.retryCount,_this.createdAt,_this.lastAttemptAt,_this.errorMessage,_this.status);
}

@override
String toString() {
  final _this = this as SyncQueueItem;
  return 'SyncQueueItem(id: ${_this.id}, entityType: ${_this.entityType}, entityId: ${_this.entityId}, operation: ${_this.operation}, payload: ${_this.payload}, retryCount: ${_this.retryCount}, createdAt: ${_this.createdAt}, lastAttemptAt: ${_this.lastAttemptAt}, errorMessage: ${_this.errorMessage}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $SyncQueueItemCopyWith<$Res>  {
  factory $SyncQueueItemCopyWith(SyncQueueItem value, $Res Function(SyncQueueItem) _then) = _$SyncQueueItemCopyWithImpl;
@useResult
$Res call({
 String id, SyncEntityType entityType, String entityId, SyncOperation operation, Map<String, dynamic> payload, int retryCount, DateTime createdAt, DateTime? lastAttemptAt, String? errorMessage, SyncStatus status
});




}
/// @nodoc
class _$SyncQueueItemCopyWithImpl<$Res>
    implements $SyncQueueItemCopyWith<$Res> {
  _$SyncQueueItemCopyWithImpl(this._self, this._then);

  final SyncQueueItem _self;
  final $Res Function(SyncQueueItem) _then;

/// Create a copy of SyncQueueItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? entityType = null,Object? entityId = null,Object? operation = null,Object? payload = null,Object? retryCount = null,Object? createdAt = null,Object? lastAttemptAt = freezed,Object? errorMessage = freezed,Object? status = null,}) {
  return _then(SyncQueueItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as SyncEntityType,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as SyncOperation,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastAttemptAt: freezed == lastAttemptAt ? _self.lastAttemptAt : lastAttemptAt // ignore: cast_nullable_to_non_nullable
as DateTime?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SyncStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncQueueItem].
extension SyncQueueItemPatterns on SyncQueueItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncQueueItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncQueueItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncQueueItem value)  $default,){
final _that = this;
switch (_that) {
case _SyncQueueItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncQueueItem value)?  $default,){
final _that = this;
switch (_that) {
case _SyncQueueItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  SyncEntityType entityType,  String entityId,  SyncOperation operation,  Map<String, dynamic> payload,  int retryCount,  DateTime createdAt,  DateTime? lastAttemptAt,  String? errorMessage,  SyncStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncQueueItem() when $default != null:
return $default(_that.id,_that.entityType,_that.entityId,_that.operation,_that.payload,_that.retryCount,_that.createdAt,_that.lastAttemptAt,_that.errorMessage,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  SyncEntityType entityType,  String entityId,  SyncOperation operation,  Map<String, dynamic> payload,  int retryCount,  DateTime createdAt,  DateTime? lastAttemptAt,  String? errorMessage,  SyncStatus status)  $default,) {final _that = this;
switch (_that) {
case _SyncQueueItem():
return $default(_that.id,_that.entityType,_that.entityId,_that.operation,_that.payload,_that.retryCount,_that.createdAt,_that.lastAttemptAt,_that.errorMessage,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  SyncEntityType entityType,  String entityId,  SyncOperation operation,  Map<String, dynamic> payload,  int retryCount,  DateTime createdAt,  DateTime? lastAttemptAt,  String? errorMessage,  SyncStatus status)?  $default,) {final _that = this;
switch (_that) {
case _SyncQueueItem() when $default != null:
return $default(_that.id,_that.entityType,_that.entityId,_that.operation,_that.payload,_that.retryCount,_that.createdAt,_that.lastAttemptAt,_that.errorMessage,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncQueueItem implements SyncQueueItem {
  const _SyncQueueItem({required this.id, required this.entityType, required this.entityId, required this.operation, required  Map<String, dynamic> payload, required this.retryCount, required this.createdAt, this.lastAttemptAt, this.errorMessage, this.status = SyncStatus.pending}): _payload = payload;
  factory _SyncQueueItem.fromJson(Map<String, dynamic> json) => _$SyncQueueItemFromJson(json);

@override final  String id;
@override final  SyncEntityType entityType;
@override final  String entityId;
@override final  SyncOperation operation;
 final  Map<String, dynamic> _payload;
@override Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}

@override final  int retryCount;
@override final  DateTime createdAt;
@override final  DateTime? lastAttemptAt;
@override final  String? errorMessage;
@override@JsonKey() final  SyncStatus status;

/// Create a copy of SyncQueueItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncQueueItemCopyWith<_SyncQueueItem> get copyWith => __$SyncQueueItemCopyWithImpl<_SyncQueueItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncQueueItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncQueueItem&&(identical(other.id, id) || other.id == id)&&(identical(other.entityType, entityType) || other.entityType == entityType)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.operation, operation) || other.operation == operation)&&const DeepCollectionEquality().equals(other.payload, _payload)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastAttemptAt, lastAttemptAt) || other.lastAttemptAt == lastAttemptAt)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,entityType,entityId,operation,const DeepCollectionEquality().hash(_payload),retryCount,createdAt,lastAttemptAt,errorMessage,status);
}

@override
String toString() {
    return 'SyncQueueItem(id: $id, entityType: $entityType, entityId: $entityId, operation: $operation, payload: $payload, retryCount: $retryCount, createdAt: $createdAt, lastAttemptAt: $lastAttemptAt, errorMessage: $errorMessage, status: $status)';
}


}

/// @nodoc
abstract mixin class _$SyncQueueItemCopyWith<$Res> implements $SyncQueueItemCopyWith<$Res> {
  factory _$SyncQueueItemCopyWith(_SyncQueueItem value, $Res Function(_SyncQueueItem) _then) = __$SyncQueueItemCopyWithImpl;
@override @useResult
$Res call({
 String id, SyncEntityType entityType, String entityId, SyncOperation operation, Map<String, dynamic> payload, int retryCount, DateTime createdAt, DateTime? lastAttemptAt, String? errorMessage, SyncStatus status
});




}
/// @nodoc
class __$SyncQueueItemCopyWithImpl<$Res>
    implements _$SyncQueueItemCopyWith<$Res> {
  __$SyncQueueItemCopyWithImpl(this._self, this._then);

  final _SyncQueueItem _self;
  final $Res Function(_SyncQueueItem) _then;

/// Create a copy of SyncQueueItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? entityType = null,Object? entityId = null,Object? operation = null,Object? payload = null,Object? retryCount = null,Object? createdAt = null,Object? lastAttemptAt = freezed,Object? errorMessage = freezed,Object? status = null,}) {
  return _then(_SyncQueueItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,entityType: null == entityType ? _self.entityType : entityType // ignore: cast_nullable_to_non_nullable
as SyncEntityType,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as SyncOperation,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastAttemptAt: freezed == lastAttemptAt ? _self.lastAttemptAt : lastAttemptAt // ignore: cast_nullable_to_non_nullable
as DateTime?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SyncStatus,
  ));
}


}

// dart format on
