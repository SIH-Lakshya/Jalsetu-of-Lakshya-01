import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_queue.freezed.dart';
part 'sync_queue.g.dart';

@freezed
abstract class SyncQueueItem with _$SyncQueueItem {
  const factory SyncQueueItem({
    required String id,
    required SyncEntityType entityType,
    required String entityId,
    required SyncOperation operation,
    required Map<String, dynamic> payload,
    required int retryCount,
    required DateTime createdAt,
    DateTime? lastAttemptAt,
    String? errorMessage,
    @Default(SyncStatus.pending) SyncStatus status,
  }) = _SyncQueueItem;

  factory SyncQueueItem.fromJson(Map<String, dynamic> json) => _$SyncQueueItemFromJson(json);
}

enum SyncEntityType {
  @JsonValue('observation')
  observation,
  @JsonValue('intervention')
  intervention,
  @JsonValue('photo')
  photo,
}

enum SyncOperation {
  @JsonValue('create')
  create,
  @JsonValue('update')
  update,
  @JsonValue('delete')
  delete,
}

enum SyncStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
}