// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_log_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseLogDTO _$ExerciseLogDTOFromJson(Map<String, dynamic> json) =>
    ExerciseLogDTO(
      json['id'] as String,
      json['skillName'] as String?,
      json['accountId'] as String,
      json['styleId'] as String,
      DateTime.parse(json['exerciseDateTime'] as String),
      json['exerciseTime'] as int,
      json['feeling'] as String,
      json['groupNumber'] as int,
      json['number'] as int,
    )..createTime = json['createTime'] as String?;

Map<String, dynamic> _$ExerciseLogDTOToJson(ExerciseLogDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'skillName': instance.skillName,
      'accountId': instance.accountId,
      'styleId': instance.styleId,
      'exerciseDateTime': instance.exerciseDateTime.toIso8601String(),
      'exerciseTime': instance.exerciseTime,
      'feeling': instance.feeling,
      'groupNumber': instance.groupNumber,
      'number': instance.number,
    };
