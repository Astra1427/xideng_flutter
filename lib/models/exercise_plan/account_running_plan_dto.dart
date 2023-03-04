import 'package:xideng_flutter/models/model_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_running_plan_dto.g.dart';

@JsonSerializable()
class AccountRunningPlanDTO extends ModelBase {
  String accountId;

  String planId;

  DateTime? startTime;

  bool isPause;

  AccountRunningPlanDTO(
      super.id, this.accountId, this.planId, this.startTime, this.isPause);

  Map<String,dynamic> toJson() => _$AccountRunningPlanDTOToJson(this);
  factory AccountRunningPlanDTO.fromJson(Map<String,dynamic> json) => _$AccountRunningPlanDTOFromJson(json);
}
