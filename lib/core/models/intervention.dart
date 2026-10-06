import 'package:freezed_annotation/freezed_annotation.dart';

part 'intervention.freezed.dart';
part 'intervention.g.dart';

@freezed
abstract class Intervention with _$Intervention {
  const factory Intervention({
    required String id,
    required String watershedId,
    required String name,
    required InterventionType type,
    required InterventionStatus status,
    required String description,
    required DateTime plannedDate,
    DateTime? actualDate,
    required double estimatedCost,
    double? actualCost,
    String? contractor,
    List<String>? photoIds,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Intervention;

  factory Intervention.fromJson(Map<String, dynamic> json) => _$InterventionFromJson(json);
}

enum InterventionType {
  @JsonValue('check_dam')
  checkDam,
  @JsonValue('contour_trench')
  contourTrench,
  @JsonValue('percolation_tank')
  percolationTank,
  @JsonValue('plantation')
  plantation,
  @JsonValue('gully_plug')
  gullyPlug,
  @JsonValue('farm_pond')
  farmPond,
  @JsonValue('recharge_shaft')
  rechargeShaft,
  @JsonValue('other')
  other,
}

enum InterventionStatus {
  @JsonValue('planned')
  planned,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('verified')
  verified,
  @JsonValue('cancelled')
  cancelled,
}