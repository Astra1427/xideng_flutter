// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_style_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillStyleDTO _$SkillStyleDTOFromJson(Map<String, dynamic> json) =>
    SkillStyleDTO(
      json['id'] as String,
      json['skillId'] as String,
      json['name'] as String,
      json['img1Url'] as String,
      json['img2Url'] as String,
      json['traningPart'] as String,
      json['actionDescription'] as String,
      json['analysis'] as String,
      json['slowSteady'] as String,
      json['orderNumber'] as int,
      json['traningType'] as bool,
      json['isSingle'] as bool,
      (json['standards'] as List<dynamic>?)
          ?.map((e) => StandardDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['skillName'] as String,
      videoUrl: json['videoUrl'] as String?,
    )..createTime = json['createTime'] as String?;

Map<String, dynamic> _$SkillStyleDTOToJson(SkillStyleDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'skillId': instance.skillId,
      'name': instance.name,
      'img1Url': instance.img1Url,
      'img2Url': instance.img2Url,
      'videoUrl': instance.videoUrl,
      'traningPart': instance.traningPart,
      'actionDescription': instance.actionDescription,
      'analysis': instance.analysis,
      'slowSteady': instance.slowSteady,
      'orderNumber': instance.orderNumber,
      'traningType': instance.traningType,
      'isSingle': instance.isSingle,
      'standards': instance.standards,
      'skillName': instance.skillName,
    };
