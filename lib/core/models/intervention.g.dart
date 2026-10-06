// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervention.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Intervention _$InterventionFromJson(Map<String, dynamic> json) =>
    _Intervention(
      id: json['id'] as String,
      watershedId: json['watershedId'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$InterventionTypeEnumMap, json['type']),
      status: $enumDecode(_$InterventionStatusEnumMap, json['status']),
      description: json['description'] as String,
      plannedDate: DateTime.parse(json['plannedDate'] as String),
      actualDate: json['actualDate'] == null
          ? null
          : DateTime.parse(json['actualDate'] as String),
      estimatedCost: (json['estimatedCost'] as num).toDouble(),
      actualCost: (json['actualCost'] as num?)?.toDouble(),
      contractor: json['contractor'] as String?,
      photoIds: (json['photoIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$InterventionToJson(_Intervention instance) =>
    <String, dynamic>{
      'id': instance.id,
      'watershedId': instance.watershedId,
      'name': instance.name,
      'type': _$InterventionTypeEnumMap[instance.type]!,
      'status': _$InterventionStatusEnumMap[instance.status]!,
      'description': instance.description,
      'plannedDate': instance.plannedDate.toIso8601String(),
      'actualDate': instance.actualDate?.toIso8601String(),
      'estimatedCost': instance.estimatedCost,
      'actualCost': instance.actualCost,
      'contractor': instance.contractor,
      'photoIds': instance.photoIds,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$InterventionTypeEnumMap = {
  InterventionType.checkDam: 'check_dam',
  InterventionType.contourTrench: 'contour_trench',
  InterventionType.percolationTank: 'percolation_tank',
  InterventionType.plantation: 'plantation',
  InterventionType.gullyPlug: 'gully_plug',
  InterventionType.farmPond: 'farm_pond',
  InterventionType.rechargeShaft: 'recharge_shaft',
  InterventionType.other: 'other',
};

const _$InterventionStatusEnumMap = {
  InterventionStatus.planned: 'planned',
  InterventionStatus.inProgress: 'in_progress',
  InterventionStatus.completed: 'completed',
  InterventionStatus.verified: 'verified',
  InterventionStatus.cancelled: 'cancelled',
};
