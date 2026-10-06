// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyncQueueItem _$SyncQueueItemFromJson(Map<String, dynamic> json) =>
    _SyncQueueItem(
      id: json['id'] as String,
      entityType: $enumDecode(_$SyncEntityTypeEnumMap, json['entityType']),
      entityId: json['entityId'] as String,
      operation: $enumDecode(_$SyncOperationEnumMap, json['operation']),
      payload: json['payload'] as Map<String, dynamic>,
      retryCount: (json['retryCount'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastAttemptAt: json['lastAttemptAt'] == null
          ? null
          : DateTime.parse(json['lastAttemptAt'] as String),
      errorMessage: json['errorMessage'] as String?,
      status:
          $enumDecodeNullable(_$SyncStatusEnumMap, json['status']) ??
          SyncStatus.pending,
    );

Map<String, dynamic> _$SyncQueueItemToJson(_SyncQueueItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entityType': _$SyncEntityTypeEnumMap[instance.entityType]!,
      'entityId': instance.entityId,
      'operation': _$SyncOperationEnumMap[instance.operation]!,
      'payload': instance.payload,
      'retryCount': instance.retryCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastAttemptAt': instance.lastAttemptAt?.toIso8601String(),
      'errorMessage': instance.errorMessage,
      'status': _$SyncStatusEnumMap[instance.status]!,
    };

const _$SyncEntityTypeEnumMap = {
  SyncEntityType.observation: 'observation',
  SyncEntityType.intervention: 'intervention',
  SyncEntityType.photo: 'photo',
};

const _$SyncOperationEnumMap = {
  SyncOperation.create: 'create',
  SyncOperation.update: 'update',
  SyncOperation.delete: 'delete',
};

const _$SyncStatusEnumMap = {
  SyncStatus.pending: 'pending',
  SyncStatus.inProgress: 'in_progress',
  SyncStatus.completed: 'completed',
  SyncStatus.failed: 'failed',
};
