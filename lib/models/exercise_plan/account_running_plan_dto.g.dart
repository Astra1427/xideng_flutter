// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_running_plan_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountRunningPlanDTO _$AccountRunningPlanDTOFromJson(
        Map<String, dynamic> json) =>
    AccountRunningPlanDTO(
      json['id'] as String,
      json['accountId'] as String,
      json['planId'] as String,
      json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      json['isPause'] as bool,
    )..createTime = json['createTime'] as String?;

Map<String, dynamic> _$AccountRunningPlanDTOToJson(
        AccountRunningPlanDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'accountId': instance.accountId,
      'planId': instance.planId,
      'startTime': instance.startTime?.toIso8601String(),
      'isPause': instance.isPause,
    };
