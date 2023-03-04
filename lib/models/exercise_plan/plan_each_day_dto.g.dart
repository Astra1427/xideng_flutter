// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_each_day_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanEachDayDTO _$PlanEachDayDTOFromJson(Map<String, dynamic> json) =>
    PlanEachDayDTO(
      json['id'] as String,
      json['planId'] as String,
      json['styleID'] as String?,
      json['dayNumber'] as int,
      json['groupNumber'] as int?,
      json['number'] as int?,
      json['time'] as String,
      json['isRestDay'] as bool,
      json['orderNumber'] as int,
    )..createTime = json['createTime'] as String?;

Map<String, dynamic> _$PlanEachDayDTOToJson(PlanEachDayDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'planId': instance.planId,
      'styleID': instance.styleID,
      'dayNumber': instance.dayNumber,
      'groupNumber': instance.groupNumber,
      'number': instance.number,
      'time': instance.time,
      'isRestDay': instance.isRestDay,
      'orderNumber': instance.orderNumber,
    };
