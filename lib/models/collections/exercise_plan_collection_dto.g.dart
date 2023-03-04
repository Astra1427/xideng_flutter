// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_plan_collection_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisePlanCollectionDTO _$ExercisePlanCollectionDTOFromJson(
        Map<String, dynamic> json) =>
    ExercisePlanCollectionDTO(
      json['id'] as String,
      json['exercisePlanId'] as String,
      json['collectionFolderId'] as String,
    )..createTime = json['createTime'] as String?;

Map<String, dynamic> _$ExercisePlanCollectionDTOToJson(
        ExercisePlanCollectionDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'exercisePlanId': instance.exercisePlanId,
      'collectionFolderId': instance.collectionFolderId,
    };
