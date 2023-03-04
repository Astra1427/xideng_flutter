// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillDTO _$SkillDTOFromJson(Map<String, dynamic> json) => SkillDTO(
      json['id'] as String,
      json['name'] as String,
      json['description'] as String?,
      json['imgUrl'] as String?,
      json['ownerId'] as String,
      json['orderNumber'] as int,
      (json['skillStyles'] as List<dynamic>)
          .map((e) => SkillStyleDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..createTime = json['createTime'] as String?;

Map<String, dynamic> _$SkillDTOToJson(SkillDTO instance) => <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'name': instance.name,
      'description': instance.description,
      'imgUrl': instance.imgUrl,
      'ownerId': instance.ownerId,
      'orderNumber': instance.orderNumber,
      'skillStyles': instance.skillStyles,
    };
