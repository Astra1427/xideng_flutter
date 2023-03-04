import 'package:xideng_flutter/models/skill/skill_dto.dart';

import 'account/account_dto.dart';
import 'collections/collection_folder_dto.dart';
import 'exercise_logs/exercise_log_dto.dart';
import 'exercise_plan/account_running_plan_dto.dart';
import 'exercise_plan/exercise_plan_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sync_dto.g.dart';

@JsonSerializable()
class SyncDTO{
  AccountDTO account;
  List<ExercisePlanDTO> exercisePlans;

  SkillDTO skill;
  List<AccountRunningPlanDTO> runningPlans;

  /// <summary>
  /// Only CTL
  /// </summary>
  List<CollectionFolderDTO> collectionFolders;

  /// <summary>
  /// Only CTL
  /// </summary>
  List<ExercisePlanDTO> plansOfCollectionFolders;
  List<ExerciseLogDTO> exerciseLogs;

  SyncDTO(this.account, this.exercisePlans, this.skill, this.runningPlans,
      this.collectionFolders, this.plansOfCollectionFolders, this.exerciseLogs);

  Map<String,dynamic> toJson() => _$SyncDTOToJson(this);
  factory SyncDTO.fromJson(Map<String,dynamic> json) => _$SyncDTOFromJson(json);
}