// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_folder_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionFolderDTO _$CollectionFolderDTOFromJson(Map<String, dynamic> json) =>
    CollectionFolderDTO(
      json['id'] as String,
      json['accountId'] as String,
      json['name'] as String,
      json['isPublic'] as bool,
      (json['exercisePlanCollections'] as List<dynamic>)
          .map((e) =>
              ExercisePlanCollectionDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..createTime = json['createTime'] as String?;

Map<String, dynamic> _$CollectionFolderDTOToJson(
        CollectionFolderDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'accountId': instance.accountId,
      'name': instance.name,
      'isPublic': instance.isPublic,
      'exercisePlanCollections': instance.exercisePlanCollections,
    };
