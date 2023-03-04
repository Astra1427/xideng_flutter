// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_plan_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisePlanDTO _$ExercisePlanDTOFromJson(Map<String, dynamic> json) =>
    ExercisePlanDTO(
      json['id'] as String,
      json['accountId'] as String,
      json['cycle'] as int,
      json['collectionCount'] as int,
      json['isPublic'] as bool,
      json['isLoop'] as bool,
      json['name'] as String,
      json['description'] as String?,
      json['coverUrl'] as String?,
      (json['planEachDays'] as List<dynamic>?)
          ?.map((e) => PlanEachDayDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['authorImg'] as String?,
      json['authorName'] as String?,
    )..createTime = json['createTime'] as String?;

Map<String, dynamic> _$ExercisePlanDTOToJson(ExercisePlanDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'accountId': instance.accountId,
      'cycle': instance.cycle,
      'collectionCount': instance.collectionCount,
      'isPublic': instance.isPublic,
      'isLoop': instance.isLoop,
      'name': instance.name,
      'description': instance.description,
      'coverUrl': instance.coverUrl,
      'planEachDays': instance.planEachDays,
      'authorImg': instance.authorImg,
      'authorName': instance.authorName,
    };
