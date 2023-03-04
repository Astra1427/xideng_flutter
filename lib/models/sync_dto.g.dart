// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncDTO _$SyncDTOFromJson(Map<String, dynamic> json) => SyncDTO(
      AccountDTO.fromJson(json['account'] as Map<String, dynamic>),
      (json['exercisePlans'] as List<dynamic>)
          .map((e) => ExercisePlanDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      SkillDTO.fromJson(json['skill'] as Map<String, dynamic>),
      (json['runningPlans'] as List<dynamic>)
          .map((e) => AccountRunningPlanDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['collectionFolders'] as List<dynamic>)
          .map((e) => CollectionFolderDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['plansOfCollectionFolders'] as List<dynamic>)
          .map((e) => ExercisePlanDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['exerciseLogs'] as List<dynamic>)
          .map((e) => ExerciseLogDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SyncDTOToJson(SyncDTO instance) => <String, dynamic>{
      'account': instance.account,
      'exercisePlans': instance.exercisePlans,
      'skill': instance.skill,
      'runningPlans': instance.runningPlans,
      'collectionFolders': instance.collectionFolders,
      'plansOfCollectionFolders': instance.plansOfCollectionFolders,
      'exerciseLogs': instance.exerciseLogs,
    };
